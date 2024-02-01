class PipesHelper {
  static int getColumnNumber(int index, int itemsInRow) {
    return index < itemsInRow
        ? index
        : index < 2 * itemsInRow
            ? index - itemsInRow
            : index < 3 * itemsInRow
                ? index - 2 * itemsInRow
                : index - 3 * itemsInRow;
  }

  static int getRowNumber(int index, int itemsInRow) {
    return index < itemsInRow
        ? 0
        : index < 2 * itemsInRow
            ? 1
            : index < 3 * itemsInRow
                ? 2
                : 3;
  }
}
