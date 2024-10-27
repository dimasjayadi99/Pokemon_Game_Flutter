class TextFormatter{
  String capitalize(String name) {
    if (name.isEmpty) return name;

    final words = name.split(' ');

    final capitalizedWords = words.map((word) {
      return word.length > 1
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : word.toUpperCase();
    });

    return capitalizedWords.join(' ');
  }
}