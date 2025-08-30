import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';

class SearchButton extends StatefulWidget {
  final IconData icon;
  final String text;
  const SearchButton({super.key, required this.icon, required this.text});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  bool isHoaver = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHoaver = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHoaver = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isHoaver ? AppColors.proButton : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(widget.icon, size: 20, color: AppColors.iconGrey),
            SizedBox(width: 8),
            Text(
              widget.text,
              style: TextStyle(fontSize: 14, color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}
