import 'package:better_world/connectivity/connectivity_controller.dart';
import 'package:better_world/connectivity/no_connection_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:better_world/player_progress/persistence/database_persistence.dart';
import 'package:better_world/player_progress/persistence/firebase_persistence.dart';
import 'package:better_world/player_progress/persistence/local_player_persistence.dart';
import 'package:better_world/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'firebase_options.dart';
import 'player_progress/player_progress_controller.dart';
import 'router.dart';
import 'settings/settings.dart';
import 'style/palette.dart';

void main() async {
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (deviceSize) {
      const double widthOfDesign = 800;

      return deviceSize.width / widthOfDesign;
    },
  );

  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebasePersistence = FirebasePersistence(
    firestore: FirebaseFirestore.instance,
  );
  final localPlayerPersistence = LocalPlayerPersistence(
    sharedPrefs: SharedPreferences.getInstance(),
  );

  runApp(
    BetterWorldGame(
      firebasePersistence: firebasePersistence,
      localPlayerPersistence: localPlayerPersistence,
    ),
/*    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => BetterWorldGame(
        firebasePersistence: firebasePersistence,
        localPlayerPersistence: localPlayerPersistence,
      ),
    ),*/
  );
}

class BetterWorldGame extends StatelessWidget {
  const BetterWorldGame({
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
          ChangeNotifierProvider(
            create: (context) => ConnectivityController(),
          ),
          Provider(create: (_) => SettingsController()),
          ProxyProvider2<SettingsController, AppLifecycleStateNotifier, AudioController>(
            // Ensures that music starts immediately.
            lazy: false,
            create: (_) => AudioController(),
            update: (_, settings, lifecycleNotifier, audio) {
              audio!.attachDependencies(lifecycleNotifier, settings);
              return audio;
            },
            dispose: (_, audio) => audio.dispose(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: 'Better World',
              theme: theme,
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              builder: (context, child) {
                final connectivityController = context.watch<ConnectivityController>();
                if (connectivityController.isConnected) {
                  return child!;
                } else {
                  return const NoConnectionScreen();
                }
              },
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
