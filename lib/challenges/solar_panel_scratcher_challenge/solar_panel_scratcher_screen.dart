import 'dart:async';

import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/dialog_helper.dart';
import 'package:endless_runner/common/exit_challenge_dialog.dart';
import 'package:endless_runner/common/icon_button.dart';
import 'package:endless_runner/common/points_counter.dart';
import 'package:endless_runner/common/success_dialog.dart';
import 'package:endless_runner/common/timer_widget.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class SolarPanelChallengeScreen extends StatefulWidget {
  const SolarPanelChallengeScreen({super.key});

  static const String routePath = '/solar-panel-scratcher';

  @override
  State<SolarPanelChallengeScreen> createState() => _SolarPanelChallengeScreenState();
}

class _SolarPanelChallengeScreenState extends State<SolarPanelChallengeScreen> {
  late double _scratchedValue = 0;
  late int _timeInSeconds = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _incrementTimer);
  }

  void _incrementTimer(Timer timer) {
    setState(() {
      _timeInSeconds++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;

    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        _showExitDialog();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Scratcher(
              rebuildOnResize: false,
              brushSize: 300,
              threshold: 100,
              image: Image.network(
                "https://user-images.githubusercontent.com/5700795/36454160-b4f9253a-1692-11e8-916e-65cd4abe981a.png",
              ),
              onChange: (double value) {
                setState(() {
                  _scratchedValue = value;
                });
              },
              onThreshold: () => _showFinishDialog(),
              child: SizedBox(
                height: height,
                width: width,
                child: Image.network(
                  "https://static.vecteezy.com/system/resources/previews/002/046/668/large_2x/solar-panel-isolated-on-white-background-free-vector.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    gap40,
                    PointsCounter(pointsCount: _scratchedValue.floor()),
                    gap16,
                    TimerWidget(timeInSeconds: _timeInSeconds),
                    const Spacer(),
                    GameIconButton(
                      iconName: AssetPaths.iconsInfo,
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      onTap: () => _showIntroDialog(),
                    ),
                    gap16,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 36, bottom: 24),
                child: GameIconButton(
                  onTap: () => _showExitDialog(),
                  iconName: AssetPaths.iconsMap,
                  width: 56,
                  height: 56,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFinishDialog() {
    _timer.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const SuccessDialog(
          challengeName: 'solar panel scratcher',
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showExitDialog() {
    DialogHelper.showWithWidgetBinding(
      context,
      const ExitChallengeDialog(),
    );
  }

  void _showIntroDialog() {
    print("TODO _showIntroDialog");
  }
}
