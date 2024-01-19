import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> expectFirestoreSetCall({
  required CollectionReference<Map<String, dynamic>> collection,
  required Map<String, dynamic> data,
  required String docId,
}) async {
  await collection.doc(docId).set(data);
  expect(() => collection.doc(docId).set(data), returnsNormally);
  final result = await collection.doc(docId).get();
  expect(result.data(), data);
}

Future<void> expectFirestoreGetCall({
  required CollectionReference<Map<String, dynamic>> collection,
  required dynamic matcher,
  required String docId,
}) async {
  final result = await collection.doc(docId).get();
  expect(
    () => collection.doc(docId).get(),
    returnsNormally,
  );
  debugPrint('Result data: ${result.data()}');
  expect(result.data(), matcher);
}
