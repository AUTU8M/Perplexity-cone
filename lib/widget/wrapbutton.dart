import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';

class Wrapbutton extends StatelessWidget {
  final String text;
  const Wrapbutton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: AppColors.footerGrey),
      ),
    );
  }
}
