import 'package:flutter/material.dart';
import 'package:perplexity/widget/search_section.dart';
import 'package:perplexity/widget/side_navbar.dart';
import 'package:perplexity/widget/wrapbutton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideNavbar(),

          Expanded(
            child: Column(
              children: [
                Expanded(child: SearchSection()),
                //footer
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Wrapbutton(text: "pro"),
                      Wrapbutton(text: "Enterprise"),
                      Wrapbutton(text: "Store"),
                      Wrapbutton(text: "blog"),
                      Wrapbutton(text: "Carrers"),
                      Wrapbutton(text: "English(English)"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
