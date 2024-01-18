import 'package:endless_runner/challenges/recycling_challenge/garbage_controller.dart';
import 'package:endless_runner/challenges/recycling_challenge/garbage_type_enum.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DumpsterType {
  recyclable(assetPath: AssetPaths.dumpsterRecycling),
  other(assetPath: AssetPaths.dumpster);

  const DumpsterType({required this.assetPath});

  final String assetPath;
}

class DumpsterWidget extends StatefulWidget {
  const DumpsterWidget({
    super.key,
    required this.dumpsterType,
  });

  final DumpsterType dumpsterType;

  @override
  State<DumpsterWidget> createState() => _DumpsterWidgetState();
}

class _DumpsterWidgetState extends State<DumpsterWidget> {
  @override
  Widget build(BuildContext context) {
    final garbageController = context.read<GarbageController>();
    return DragTarget<GarbageType>(
      onWillAccept: (data) => data?.dumpsterType == widget.dumpsterType,
      onAccept: (data) => garbageController.itemSorted(data),
      builder: (_, __, rejectedData) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            rejectedData.isNotEmpty
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.red.withOpacity(0.8),
                      BlendMode.modulate,
                    ),
                    child: DumpsterImage(
                      dumpsterType: widget.dumpsterType,
                    ),
                  )
                : DumpsterImage(
                    dumpsterType: widget.dumpsterType,
                  ),
            if (rejectedData.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 32,
                ),
              ),
          ],
        );
      },
    );
  }
}

class DumpsterImage extends StatelessWidget {
  const DumpsterImage({
    super.key,
    required this.dumpsterType,
  });

  final DumpsterType dumpsterType;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      dumpsterType.assetPath,
      width: 150,
      color: dumpsterType == DumpsterType.other ? Colors.grey : null,
    );
  }
}
