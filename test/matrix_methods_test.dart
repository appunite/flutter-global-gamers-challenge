import 'package:better_world/challenges/pipes_challenge/pipes_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Check correct row for 15-element grid (3x5)', () {
    const int itemsInRow = 5;
    test('for 2nd element in the list', () {
      const int expectedRow = 0;
      const int index = 1;

      expect(PipesHelper.getRowNumber(index, itemsInRow), expectedRow);
    });

    test('for 6th element in the list', () {
      const int expectedRow = 1;
      const int index = 5;

      expect(PipesHelper.getRowNumber(index, itemsInRow), expectedRow);
    });

    test('for 15th element in the list', () {
      const int expectedRow = 2;
      const int index = 14;

      expect(PipesHelper.getRowNumber(index, itemsInRow), expectedRow);
    });
  });

  group('Check correct column for 15-element grid (3x5)', () {
    const int itemsInRow = 5;
    test('for 2nd element in the list', () {
      const int expectedColumn = 1;
      const int index = 1;

      expect(PipesHelper.getColumnNumber(index, itemsInRow), expectedColumn);
    });

    test('for 6th element in the list', () {
      const int expectedColumn = 0;
      const int index = 5;

      expect(PipesHelper.getColumnNumber(index, itemsInRow), expectedColumn);
    });

    test('for 15th element in the list', () {
      const int expectedColumn = 4;
      const int index = 14;

      expect(PipesHelper.getColumnNumber(index, itemsInRow), expectedColumn);
    });
  });
}
