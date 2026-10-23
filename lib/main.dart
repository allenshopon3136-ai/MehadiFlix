import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MehadiflixApp());
}

class MehadiflixApp extends StatelessWidget {
  const MehadiflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mehadiflix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50914), // Netflix Red
          secondary: Colors.redAccent,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// ==================== DATA MODEL ====================
class MediaContent {
  final String id;
  final String title;
  final String posterUrl;
  final String category;
  final String videoUrl;
  final String description;

  MediaContent({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.category,
    required this.videoUrl,
    required this.description,
  });

  factory MediaContent.fromJson(Map<String, dynamic> json) {
    return MediaContent(
      id: json['id']?.toString() ?? '1',
      title: json['title'] ?? json['name'] ?? 'Mehadiflix Movie',
      posterUrl: json['poster_url'] ?? json['image'] ?? 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800',
      category: json['category'] ?? 'Trending',
      videoUrl: json['video_url'] ?? json['url'] ?? 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
      description: json['description'] ?? 'Streamed directly from fojik.site source.',
    );
  }
}

// ==================== FOJIK.SITE SERVICE ====================
class ContentService {
  static const String websiteUrl = 'https://fojik.site/';

  static Future<List<MediaContent>> fetchFojikContents() async {
    try {
      final response = await http.get(Uri.parse(websiteUrl));
