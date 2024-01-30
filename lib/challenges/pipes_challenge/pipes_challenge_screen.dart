import 'package:endless_runner/challenges/pipes_challenge/pipes_grid.dart';
import 'package:flutter/material.dart';

class PipesChallengeScreen extends StatelessWidget {
  const PipesChallengeScreen({super.key});

  static const String routePath = '/pipes-challenge';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: const SafeArea(
        left: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PipesGrid(),
          ],
        ),
      ),
    );
  }
}
