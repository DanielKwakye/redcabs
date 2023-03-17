/// extensions on any [String]
///
extension StringExtension on String? {

  String capitalize() {
    assert(this != null);
    return this!
        .split(' ')
        .map(
            (str) => '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}')
        .join(' ');
  }

  bool isNullOrEmpty() => this == null || this!.isEmpty;


  List<String> splitWithDelim(RegExp pattern) =>
      pattern.allMatchesWithSep(this!);

}

extension Round on double {
  int get roundUpAbs => isNegative ? floor() : ceil();
}

extension RegExpExtension on RegExp {
  List<String> allMatchesWithSep(String input, [int start = 0]) {
    var result = <String>[];
    for (var match in allMatches(input, start)) {
      result.add(input.substring(start, match.start));
      result.add(match[0] ?? '');
      start = match.end;
    }
    result.add(input.substring(start));
    return result;
  }
}

