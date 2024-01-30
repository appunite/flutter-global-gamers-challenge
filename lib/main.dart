import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:endless_runner/change_player_name/change_player_name_controller.dart';
import 'package:endless_runner/leaderboard/leaderboard_controller.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/firebase_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:endless_runner/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'firebase_options.dart';
import 'player_progress/player_progress_controller.dart';
import 'router.dart';
import 'settings/settings.dart';
import 'style/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebasePersistence = FirebasePersistence(firestore: FirebaseFirestore.instance);
  final localPlayerPersistence = LocalPlayerPersistence(sharedPrefs: SharedPreferences.getInstance());

  runApp(
    MyGame(
      firebasePersistence: firebasePersistence,
      localPlayerPersistence: localPlayerPersistence,
    ),
  );
}

class MyGame extends StatelessWidget {
  const MyGame({
    super.key,
    required this.firebasePersistence,
    required this.localPlayerPersistence,
  });

  final FirebasePersistence firebasePersistence;
  final LocalPlayerPersistence localPlayerPersistence;

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (_) => Palette()),
          Provider<DatabasePersistence>(create: (_) => firebasePersistence),
          Provider(create: (_) => localPlayerPersistence),
          ChangeNotifierProvider(
            create: (context) => PlayerProgressController(
              databaseStorage: firebasePersistence,
              localStorage: localPlayerPersistence,
            ),
          ),
          Provider(
            create: (context) => ChangePlayerNameController(
              databaseStorage: firebasePersistence,
              localStorage: localPlayerPersistence,
            ),
          ),
          Provider(
            create: (context) => LeaderboardController(
              databaseStorage: firebasePersistence,
              localStorage: localPlayerPersistence,
            ),
          ),
          Provider(create: (context) => SettingsController()),
          // Set up audio.
          ProxyProvider2<SettingsController, AppLifecycleStateNotifier, AudioController>(
            // Ensures that music starts immediately.
            lazy: false,
            create: (context) => AudioController(),
            update: (context, settings, lifecycleNotifier, audio) {
              audio!.attachDependencies(lifecycleNotifier, settings);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: 'Endless Runner',
              theme: theme,
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
            );
          },
        ),
      ),
    );
  }
}
