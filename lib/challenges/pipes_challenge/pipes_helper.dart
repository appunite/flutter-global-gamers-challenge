class PipesHelper {
  static int getColumnNumber(int index, int itemsInRow) {
    return index < itemsInRow
        ? index
        : index < 2 * itemsInRow
            ? index - itemsInRow
            : index - 2 * itemsInRow;
  }

  static int getRowNumber(int index, int itemsInRow) {
    return index < itemsInRow
        ? 0
        : index < 2 * itemsInRow
            ? 1
            : 2;
  }
}
