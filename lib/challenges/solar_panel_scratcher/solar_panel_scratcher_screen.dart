import 'dart:async';

import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/scratcher.dart';

class SolarPanelScratcherScreen extends StatefulWidget {
  const SolarPanelScratcherScreen({super.key});

  static const String routePath = '/solar-panel-scratcher';

  @override
  State<SolarPanelScratcherScreen> createState() => _SolarPanelScratcherScreenState();
}

class _SolarPanelScratcherScreenState extends State<SolarPanelScratcherScreen> {
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
                child: Text(
                  _formattedTime(timeInSecond: _timeInSeconds),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
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
                  'You completed solar panel scratcher in $_timeInSeconds seconds.',
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
      },
    );
  }

  String _formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
