import 'package:endless_runner/challenges/pipes_challenge/pipes_grid.dart';
import 'package:flutter/material.dart';

class PipesChallengeScreen extends StatelessWidget {
  const PipesChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            PipesGrid(),
            Align(
              alignment: Alignment.topLeft,
              child: BackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
