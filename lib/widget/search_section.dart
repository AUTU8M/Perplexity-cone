import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perplexity/pages/chat_page.dart';
import 'package:perplexity/services/chat_web_service.dart';
import 'package:perplexity/theme/colors.dart';
import 'package:perplexity/widget/search_button.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final queryController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    queryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Where knowledge begins",
          style: GoogleFonts.ibmPlexMono(
            fontSize: 40,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: 700,

          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.searchBarBorder, width: 1.5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: queryController,
                  decoration: InputDecoration(
                    hintText: "Search anything ...",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: AppColors.textGrey,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SearchButton(
                      icon: Icons.auto_awesome_outlined,
                      text: 'Focus',
                    ),
                    const SizedBox(width: 14),
                    SearchButton(
                      icon: Icons.add_circle_outline,
                      text: 'Attached',
                    ),
                    const Spacer(),
                    //i want to connect o my backend here
                    GestureDetector(
                      onTap: () {
                        if (queryController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter a search query')),
                          );
                          return;
                        }
                        
                        if (!ChatWebService().isConnected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('WebSocket not connected. Check your backend server.')),
                          );
                          // Still navigate to show the page, but with static data
                        }
                        
                        ChatWebService().chat(queryController.text.trim());
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => ChatPage(
                                  question: queryController.text.trim(),
                                ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.submitButton,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.background,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
