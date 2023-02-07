extension IntExtension on int? {
 int orZero() {
    if (this != null) {
      return this!;
    } else {
      return 0;
    }
  }
}
extension StringExtension on String? {
 String orEmpty() {
    if (this != null) {
      return this!;
    } else {
      return "";
    }
  }
}
