import 'package:endless_runner/style/main_button.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      child: Container(
        color: palette.backgroundPlaySession.color,
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
            MainButton(
              onPressed: (_) {
                context.go('/');
              },
              text: 'Check your City!',
            ),
          ],
        ),
      ),
    );
  }
}
