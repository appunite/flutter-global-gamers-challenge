import 'package:endless_runner/change_player_name/change_player_name_controller.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/common_dialog.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/leaderboard/leaderboard_screen.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SetPlayerNameDialog extends StatefulWidget {
  const SetPlayerNameDialog({super.key});

  @override
  State<SetPlayerNameDialog> createState() => _SetPlayerNameDialogState();
}

class _SetPlayerNameDialogState extends State<SetPlayerNameDialog> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gap24,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                'Choose your name to stand out on the leaderboard!',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Palette.neutralBlack,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            gap12,
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'e.g., username',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 3 || value.length > 15) {
                  return 'Text must be between 3 and 15 characters';
                }
                if (!RegExp(r'^[a-zA-Z\d]+$').hasMatch(value)) {
                  return 'No special characters allowed';
                }
                return null;
              },
            ),
            gap8,
            Text(
              '- Min. 3, Max. 15 characters. \n- No special characters (e.g., @, #, \$).',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Palette.neutralBlack,
                  ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      bottom: MainButton(
        onPressed: (_) => _validateUsername(),
        text: 'Continue',
        width: 180,
      ),
      themeColor: Palette.accentLight,
      ribbon: RibbonHeader(
        ribbonImage: AssetPaths.ribbonYellow,
        text: 'Leaderboard',
        withCloseIcon: true,
        onCloseTap: () => context.pop(),
      ),
      ecoImage: AssetPaths.ecoLeaderboard,
    );
  }

  void _validateUsername() {
    if (_formKey.currentState!.validate()) {
      _updateUserName();
    }
  }

  Future<void> _updateUserName() async {
    final username = _textController.text.trim();
    await context.read<ChangePlayerNameController>().updateUserName(username: username);

    if (!context.mounted) return;
    context.go(LeaderboardScreen.routePath, extra: true);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
