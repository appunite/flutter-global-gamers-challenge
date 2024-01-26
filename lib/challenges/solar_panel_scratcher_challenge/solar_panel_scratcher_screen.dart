import 'dart:async';

import 'package:endless_runner/common/success_dialog.dart';
import 'package:endless_runner/common/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                child: Text(
                  "${_scratchedValue.floor()}%",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 36,
                ),
                child: TimerWidget(timeInSeconds: _timeInSeconds),
              ),
            ),
            Positioned(
              left: 16,
              top: 16,
              child: BackButton(
                onPressed: context.pop,
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
}
