import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondaryLight,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gap32,
              const RibbonHeader(
                text: 'No Internet Connection',
                ribbonImage: AssetPaths.ribbonRed,
              ),
              gap16,
              SvgPicture.asset(
                AssetPaths.ecoConnection,
                height: 120,
                width: 120,
              ),
              gap16,
              Text(
                'Looks like you\'re offline! \nCheck your Internet connection and come back to Better World.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Palette.neutralBlack,
                    ),
                textAlign: TextAlign.center,
              ),
              gap60,
            ],
          ),
        ),
      ),
    );
  }
}
