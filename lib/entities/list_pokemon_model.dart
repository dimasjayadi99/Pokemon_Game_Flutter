class ListPokemonModel {
  final int count;
  final String? next;
  final String? previous;
  final List<Results> results;

  ListPokemonModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ListPokemonModel.fromJson(Map<String, dynamic> json) {
    return ListPokemonModel(
      count: json['count'],
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List)
          .map((item) => Results.fromJson(item))
          .toList(),
    );
  }
}

class Results {
  final String name;
  final String url;
  String? imageUrl;

  Results({required this.name, required this.url, this.imageUrl});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      name: json['name'],
      url: json['url'],
    );
  }
}
