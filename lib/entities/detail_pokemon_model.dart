class DetailPokemonModel {
  final int height;
  final int weight;
  final String name;
  final List<ListTypes> listTypes;
  final List<ListStats> listStats;
  final List<ListAbilities> listAbilities;
  final Sprites sprites;

  DetailPokemonModel({
    required this.height,
    required this.weight,
    required this.name,
    required this.listTypes,
    required this.listStats,
    required this.listAbilities,
    required this.sprites,
  });

  factory DetailPokemonModel.fromJson(Map<String, dynamic> json) {
    return DetailPokemonModel(
      height: json['height'],
      weight: json['weight'],
      name: json['name'],
      listTypes: (json['types'] as List)
          .map((item) => ListTypes.fromJson(item))
          .toList(),
      listStats: (json['stats'] as List)
          .map((item) => ListStats.fromJson(item))
          .toList(),
      listAbilities: (json['abilities'] as List)
          .map((item) => ListAbilities.fromJson(item))
          .toList(),
      sprites: Sprites.fromJson(json['sprites']),
    );
  }
}

class ListTypes {
  final Type type;

  ListTypes({required this.type});

  factory ListTypes.fromJson(Map<String, dynamic> json) {
    return ListTypes(
      type: Type.fromJson(json['type']),
    );
  }
}

class Type {
  final String name;

  Type({required this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      name: json['name'],
    );
  }
}

class ListStats {
  final int baseStat;
  final Stat stat;

  ListStats({
    required this.baseStat,
    required this.stat,
  });

  factory ListStats.fromJson(Map<String, dynamic> json) {
    return ListStats(
      baseStat: json['base_stat'],
      stat: Stat.fromJson(json['stat']),
    );
  }

  @override
  String toString() {
    return '${stat.name}: $baseStat';
  }
}

class Stat {
  final String name;

  Stat({required this.name});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      name: json['name'],
    );
  }
}

class ListAbilities {
  final Ability ability;
  final bool isHidden;

  ListAbilities({required this.ability, required this.isHidden});

  factory ListAbilities.fromJson(Map<String, dynamic> json) {
    return ListAbilities(
      ability: Ability.fromJson(json['ability']),
      isHidden: json['is_hidden']
    );
  }
}

class Ability {
  final String name;

  Ability({required this.name});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      name: json['name'],
    );
  }
}

class Sprites {
  final String frontDefault;
  final Other other;

  Sprites({required this.frontDefault, required this.other});

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default'],
      other: Other.fromJson(json['other']),
    );
  }
}

class Other {
  final DreamWorld dreamWorld;

  Other({required this.dreamWorld});

  factory Other.fromJson(Map<String, dynamic> json) {
    return Other(
      dreamWorld: DreamWorld.fromJson(json['dream_world']),
    );
  }
}

class DreamWorld {
  final String frontDefault;

  DreamWorld({required this.frontDefault});

  factory DreamWorld.fromJson(Map<String, dynamic> json) {
    return DreamWorld(
      frontDefault: json['front_default'],
    );
  }
}