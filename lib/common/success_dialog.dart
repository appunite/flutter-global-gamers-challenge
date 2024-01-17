import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    super.key,
    required this.challengeName,
  });

  final String challengeName;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();

    return Center(
      child: NesContainer(
        backgroundColor: palette.backgroundPlaySession.color,
        width: 420,
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Well done!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'You completed $challengeName challenge!',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            NesButton(
              onPressed: () {
                context.go('/');
              },
              type: NesButtonType.normal,
              child: const Text('Check your City!'),
            ),
          ],
        ),
      ),
    );
  }
}
