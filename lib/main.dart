import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perplexity/pages/home_page.dart';
import 'package:perplexity/services/chat_web_service.dart';
import 'package:perplexity/theme/colors.dart';

void main() {
  // Initialize WebSocket connection
  ChatWebService().connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.submitButton),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme.copyWith(
            bodyMedium: const TextStyle(
              fontSize: 15,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
