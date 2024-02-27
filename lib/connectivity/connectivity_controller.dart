import 'dart:async';

import 'package:connecteo/connecteo.dart';
import 'package:flutter/material.dart';

class ConnectivityController extends ChangeNotifier {
  ConnectivityController() {
    _startSubscription();
  }

  bool get isConnected => _isConnected;
  bool _isConnected = true;

  final ConnectionChecker _connectionChecker = ConnectionChecker(hostReachabilityTimeout: const Duration(seconds: 5));
  late StreamSubscription _streamSubscription;

  void _startSubscription() {
    _streamSubscription = _connectionChecker.connectionStream.listen((isConnected) {
      _isConnected = isConnected;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
