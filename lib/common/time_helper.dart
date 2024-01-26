extension TimeHelper on int {
  String formatTime() {
    if (this <= 0) {
      return '00:00';
    } else if (this >= 3600) {
      int hours = this ~/ 3600;
      int minutes = (this % 3600) ~/ 60;
      int remainingSeconds = this % 60;

      return '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    } else {
      int sec = this % 60;
      int min = (this / 60).floor();
      String minute = min.toString().length <= 1 ? "0$min" : "$min";
      String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
      return "$minute:$second";
    }
  }
}
