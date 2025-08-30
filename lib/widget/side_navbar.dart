import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';
import 'package:perplexity/widget/side_bar_button.dart';

class SideNavbar extends StatefulWidget {
  const SideNavbar({super.key});

  @override
  State<SideNavbar> createState() => _SideNavbarState();
}

class _SideNavbarState extends State<SideNavbar> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: isCollapsed ? 65 : 130,
      color: AppColors.sideNav,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Icon(
            Icons.auto_awesome_mosaic,
            size: isCollapsed ? 30 : 45,
            color: AppColors.whiteColor,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isCollapsed
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                SideBarButton(
                  isCollapsed: isCollapsed,
                  icon: Icons.add,
                  text: "HOME",
                ),

                SideBarButton(
                  isCollapsed: isCollapsed,
                  icon: Icons.search,
                  text: "Search",
                ),

                SideBarButton(
                  isCollapsed: isCollapsed,
                  icon: Icons.public_sharp,
                  text: "Spaces",
                ),
                SideBarButton(
                  isCollapsed: isCollapsed,
                  icon: Icons.auto_awesome,
                  text: "Discover",
                ),
                SideBarButton(
                  isCollapsed: isCollapsed,
                  icon: Icons.cloud_queue,
                  text: "Library",
                ),
                const Spacer(),

                SizedBox(height: 15),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
            child: AnimatedContainer(
              duration: Duration(microseconds: 100),
              margin: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Icon(
                isCollapsed
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
