import 'package:flutter/material.dart';
import 'package:sgwen_scouts_5/shared/constants/colors.dart';

import '../network/local/local_database.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: userColor(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Opacity(
                opacity: 0.3,
                child: backgroundTheme(),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
