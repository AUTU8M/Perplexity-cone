import 'package:flutter/material.dart';

import 'package:perplexity/theme/colors.dart';

class SideBarButton extends StatelessWidget {
  final bool isCollapsed;
  final IconData icon;
  final String text;

  const SideBarButton({
    super.key,
    required this.isCollapsed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          child: Icon(icon, size: 20, color: AppColors.whiteColor),
        ),
        isCollapsed
            ? SizedBox()
            : Expanded(
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
      ],
    );
  }
}
