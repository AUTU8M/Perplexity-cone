import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:perplexity/services/chat_web_service.dart';
import 'package:perplexity/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnswerSection extends StatefulWidget {
  const AnswerSection({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  bool isLoading = true;
  bool hasReceivedData = false;
  String fullResponse = '''
Generating your personalized answer based on the most relevant sources...

This response is being crafted using advanced semantic search to provide you with the most accurate and concise information.

**Please wait while we analyze the sources and prepare your response.**
''';
  String skeletonText = '''
## Loading Response...

We're analyzing multiple sources to provide you with the most relevant and accurate information.

**Key Points Being Processed:**
- Gathering relevant information from trusted sources
- Applying semantic analysis for accuracy  
- Formatting response for optimal readability
- Cross-referencing multiple data points

**Your personalized answer will appear shortly.**
''';

  @override
  void initState() {
    super.initState();
    ChatWebService().contentStream.listen((data) {
      print('AnswerSection received content: $data');
      print('Current fullResponse length: ${fullResponse.length}');

      setState(() {
        if (!hasReceivedData) {
          // Clear the placeholder text only on the first real message
          fullResponse = "";
          hasReceivedData = true;
        }
        // Append new content
        if (data['data'] != null) {
          fullResponse += data['data'];
        }
        isLoading = false;
      });

      print('Updated fullResponse length: ${fullResponse.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.blue.shade400, size: 20),
              const SizedBox(width: 8),
              Text(
                'Answer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (!isLoading && hasReceivedData) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'AI-Powered',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Content container with better styling
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Skeletonizer(
              enabled: isLoading,
              child: Markdown(
                data: isLoading ? skeletonText : fullResponse,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                styleSheet: MarkdownStyleSheet.fromTheme(
                  Theme.of(context),
                ).copyWith(
                  // Enhanced text styling
                  p: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  h1: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  h2: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  h3: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  strong: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade300,
                  ),
                  em: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade300,
                  ),
                  listBullet: TextStyle(color: Colors.blue.shade400),
                  listIndent: 24,
                  blockquoteDecoration: BoxDecoration(
                    color: AppColors.cardColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      left: BorderSide(color: Colors.blue.shade400, width: 3),
                    ),
                  ),
                  codeblockDecoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  code: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Consolas',
                    color: Colors.green.shade300,
                  ),
                  codeblockPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ),

          // Footer info when content is loaded
          if (!isLoading && hasReceivedData) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.verified, size: 14, color: Colors.green.shade400),
                const SizedBox(width: 6),
                Text(
                  'Response generated using semantic similarity analysis',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
