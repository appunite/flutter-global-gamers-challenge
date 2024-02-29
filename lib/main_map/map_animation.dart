import 'dart:io';

import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/challenges/lights_out_challenge/lights_out_challenge_screen.dart';
import 'package:better_world/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:better_world/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:better_world/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:better_world/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:better_world/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class MapAnimation extends StatefulWidget {
  const MapAnimation({
    super.key,
  });

  @override
  State<MapAnimation> createState() => _MapAnimationState();
}

class _MapAnimationState extends State<MapAnimation> {
  late StateMachineController _mapController;
  DateTime? lastEventTime;

  void _onInit(Artboard art) {
    _mapController = StateMachineController.fromArtboard(art, 'map') as StateMachineController;
    art.addController(_mapController);
    _mapController.addEventListener(onRiveEvent);
    setState(() {});

    /// Islands inputs
    final recycleIslandInput = _mapController.findInput<bool>('pipesIsland') as SMIBool;
    final cityIslandInput = _mapController.findInput<bool>('cityIsland') as SMIBool;
    final solarIslandInput = _mapController.findInput<bool>('solarIsland') as SMIBool;
    final waterIslandInput = _mapController.findInput<bool>('waterIsland') as SMIBool;
    final forestIslandInput = _mapController.findInput<bool>('forestIsland') as SMIBool;
    final pipesInput = _mapController.findInput<bool>('cleanedWaterPipes') as SMIBool;

    /// Pins inputs
    final forestPinInput = _mapController.findInput<double>('forestPin') as SMINumber;
    final pipesPinInput = _mapController.findInput<double>('pipesPin') as SMINumber;
    final plasticPinInput = _mapController.findInput<double>('plasticPin') as SMINumber;
    final recyclePinInput = _mapController.findInput<double>('recyclePin') as SMINumber;
    final cityPinInput = _mapController.findInput<double>('cityPin') as SMINumber;
    final solarPinInput = _mapController.findInput<double>('solarPin') as SMINumber;

    final playerProgress = context.read<PlayerProgressController>();

    playerProgress.addListener(() {
      if (playerProgress.challenges.city != null) {
        cityIslandInput.change(true);
        cityPinInput.value = 2;
      } else {
        cityIslandInput.change(false);
        cityPinInput.value = 0;
      }
      if (playerProgress.challenges.pipes != null) {
        pipesInput.change(true);
        pipesPinInput.value = 2;
      } else {
        pipesInput.change(false);
        pipesPinInput.value = 0;
      }
      if (playerProgress.challenges.recycling != null) {
        recycleIslandInput.change(true);
        recyclePinInput.value = 2;
      } else {
        recycleIslandInput.change(false);
        recyclePinInput.value = 0;
      }
      if (playerProgress.challenges.solarPanel != null) {
        solarIslandInput.change(true);
        solarPinInput.value = 2;
      } else {
        solarIslandInput.change(false);
        solarPinInput.value = 0;
      }
      if (playerProgress.challenges.ocean != null) {
        waterIslandInput.change(true);
        plasticPinInput.value = 2;
      } else {
        waterIslandInput.change(false);
        plasticPinInput.value = 0;
      }
      if (playerProgress.challenges.trees != null) {
        forestIslandInput.change(true);
        forestPinInput.value = 2;
      } else {
        forestIslandInput.change(false);
        forestPinInput.value = 0;
      }

      final playedChallenges = playerProgress.challenges.getPlayedChallengesCount();

      final SMINumber worldState = _mapController.findInput<double>('pollution') as SMINumber;
      worldState.value = playedChallenges * 1.67;

      if (mounted) {
        setState(() {});
      }
    });
  }

  void onRiveEvent(RiveEvent event) {
    // Sometimes Rive is triggering the events more than once, we don't know why
    // so to not push many pages on the stack, we check the event time
    final currentTime = DateTime.now();

    if (lastEventTime == null || currentTime.difference(lastEventTime!) > const Duration(milliseconds: 500)) {
      String? route;
      if (event.name case 'Pipes Play Default Tap' || 'Pipes Replay Default Tap') {
        route = PipesChallengeScreen.routePath;
      } else if (event.name case 'Plastic Play Default Tap' || 'Plastic Replay Defaultp Tap') {
        route = OceanChallengeScreen.routePath;
      } else if (event.name case 'Recycle Pin Tap ' || 'Recycle Pin Replay Tap') {
        route = RecyclingChallengeScreen.routePath;
      } else if (event.name case 'Forest Play Default Tap' || 'Forest Replay Default Tap') {
        route = TreesChallengeScreen.routePath;
      } else if (event.name case 'City Play Default Tap' || 'City Replay Default Tap') {
        route = LightsOutChallengeScreen.routePath;
      } else if (event.name case 'Solar Panel Default Play Tap' || 'Solar Panel Default Replay Tap') {
        route = SolarPanelChallengeScreen.routePath;
      }

      if (route != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<AudioController>().playSfx(SfxType.buttonTap);
          context.push(route!);
        });
      }

      lastEventTime = currentTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      AssetPaths.mapAnimation,
      fit: kIsWeb || Platform.isMacOS ? BoxFit.contain : BoxFit.cover,
      artboard: 'map',
      onInit: _onInit,
    );
  }

  @override
  void dispose() {
    _mapController.removeEventListener(onRiveEvent);
    _mapController.dispose();
    super.dispose();
  }
}
