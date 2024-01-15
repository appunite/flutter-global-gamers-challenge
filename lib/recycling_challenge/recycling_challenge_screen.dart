import 'package:endless_runner/recycling_challenge/garbage_widget.dart';
import 'package:flutter/material.dart';

class RecyclingChallengeScreen extends StatefulWidget {
  const RecyclingChallengeScreen({super.key});

  @override
  State<RecyclingChallengeScreen> createState() => _RecyclingChallengeScreenState();
}

class _RecyclingChallengeScreenState extends State<RecyclingChallengeScreen> {
  bool _blueVisible = true;
  bool _pinkVisible = true;
  bool _orangeVisible = true;
  bool _greenVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24) + const EdgeInsets.only(top: 20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: GarbageWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildGarbage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: _blueVisible,
          child: Draggable<Color>(
            data: Colors.blue,
            childWhenDragging: const SizedBox.shrink(),
            feedback: Container(
              color: Colors.blue,
              height: 24,
              width: 24,
            ),
            child: Container(
              color: Colors.blue,
              height: 24,
              width: 24,
            ),
          ),
        ),
        Visibility(
          visible: _pinkVisible,
          child: Draggable<Color>(
            data: Colors.pink,
            childWhenDragging: const SizedBox.shrink(),
            feedback: Container(
              color: Colors.pink,
              height: 24,
              width: 24,
            ),
            child: Container(
              color: Colors.pink,
              height: 24,
              width: 24,
            ),
          ),
        ),
        Visibility(
          visible: _orangeVisible,
          child: Draggable<Color>(
            data: Colors.orange,
            childWhenDragging: const SizedBox.shrink(),
            feedback: Container(
              color: Colors.orange,
              height: 24,
              width: 24,
            ),
            child: Container(
              color: Colors.orange,
              height: 24,
              width: 24,
            ),
          ),
        ),
        Visibility(
          visible: _greenVisible,
          child: Draggable<Color>(
            data: Colors.green,
            childWhenDragging: const SizedBox.shrink(),
            feedback: Container(
              color: Colors.green,
              height: 24,
              width: 24,
            ),
            child: Container(
              color: Colors.green,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ],
    );
  }

  Row _buildBins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DragTarget<Color>(
          onWillAccept: (data) => data == Colors.blue,
          onAccept: (data) {
            print(data);
            setState(() {
              _blueVisible = false;
            });
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: 50,
              width: 50,
              color: Colors.blue,
            );
          },
        ),
        DragTarget<Color>(
          onWillAccept: (data) => data == Colors.pink,
          onAccept: (data) {
            print(data);
            setState(() {
              _pinkVisible = false;
            });
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: 50,
              width: 50,
              color: Colors.pink,
            );
          },
        ),
        DragTarget<Color>(
          onWillAccept: (data) => data == Colors.orange || data == Colors.green,
          onAccept: (data) {
            print(data);
            setState(() {
              if (data == Colors.orange) {
                _orangeVisible = false;
              } else if (data == Colors.green) {
                _greenVisible = false;
              }
            });
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: 50,
              width: 50,
              color: Colors.orange,
            );
          },
        ),
      ],
    );
  }
}
