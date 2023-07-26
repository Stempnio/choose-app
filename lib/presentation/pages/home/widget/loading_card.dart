import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:choose_app/l10n/l10n.dart';
import 'package:choose_app/presentation/constants/constants.dart';
import 'package:choose_app/presentation/utils/utils.dart';
import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(largeSize),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: mediumSize),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(context.l10n.home__choosing),
                ],
                repeatForever: true,
              ),
            ),
            VSpace.large(),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
