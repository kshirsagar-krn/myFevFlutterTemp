extension ListSearchExtension<T> on List<T> {
  List<T> search({
    required String query,
    required List<String> Function(T) fieldMapper,
    bool caseSensitive = false,
    bool matchWholeWord = false,
    bool useRegex = false,
  }) {
    if (query.isEmpty) return this;

    final searchQuery = caseSensitive ? query : query.toLowerCase();

    return where((item) {
      final fields = fieldMapper(item);

      for (final field in fields) {
        final fieldValue = field;
        final textToSearch = caseSensitive
            ? fieldValue
            : fieldValue.toLowerCase();

        if (useRegex) {
          try {
            final regex = RegExp(searchQuery, caseSensitive: caseSensitive);
            if (regex.hasMatch(textToSearch)) {
              return true;
            }
          } catch (e) {
            // If regex is invalid, fall back to contains
          }
        }

        if (matchWholeWord) {
          final words = textToSearch.split(RegExp(r'\s+'));
          if (words.any((word) => word == searchQuery)) {
            return true;
          }
        } else {
          if (textToSearch.contains(searchQuery)) {
            return true;
          }
        }
      }

      return false;
    }).toList();
  }
}
