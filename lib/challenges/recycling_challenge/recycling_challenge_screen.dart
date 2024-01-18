import 'package:endless_runner/challenges/recycling_challenge/dumpster_widget.dart';
import 'package:endless_runner/challenges/recycling_challenge/garbage_controller.dart';
import 'package:endless_runner/challenges/recycling_challenge/garbage_widget.dart';
import 'package:endless_runner/common/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecyclingChallengeScreen extends StatelessWidget {
  const RecyclingChallengeScreen({super.key});

  static const String routePath = '/recycling-challenge';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GarbageController(),
      child: const _RecyclingChallengeScreenBody(),
    );
  }
}

class _RecyclingChallengeScreenBody extends StatefulWidget {
  const _RecyclingChallengeScreenBody();

  @override
  State<_RecyclingChallengeScreenBody> createState() => _RecyclingChallengeScreenBodyState();
}

class _RecyclingChallengeScreenBodyState extends State<_RecyclingChallengeScreenBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final garbageController = Provider.of<GarbageController>(context, listen: false);
      garbageController.addListener(() {
        if (garbageController.challengeCompleted) {
          _showCompletionDialog();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFEDEDED),
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const GarbageWidget(),
                Positioned(
                  bottom: -70,
                  left: width / 6,
                  child: const DumpsterWidget(
                    dumpsterType: DumpsterType.recyclable,
                  ),
                ),
                Positioned(
                  bottom: -70,
                  left: width / 2,
                  child: const DumpsterWidget(
                    dumpsterType: DumpsterType.other,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: BackButton(onPressed: context.pop),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCompletionDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const SuccessDialog(
        challengeName: 'recycling',
      ),
    );
  }
}
