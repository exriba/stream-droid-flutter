extension StringUtil on String {
  String withCapitalizedFirstLetter() {
    if (length == 0) {
      throw const FormatException("String length must be greater than 0.");
    }
    return this[0].toUpperCase() + substring(1);
  }
}
