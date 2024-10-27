import 'dart:convert';
import 'package:pokemon_game/api/api_config.dart';
import 'package:pokemon_game/entities/detail_pokemon_model.dart';
import 'package:pokemon_game/entities/list_pokemon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

  // init base ur
  final String baseUrl = ApiConfig.baseUrl;

  // fetch list pokemon
  Future<List<Results>> fetchListPokemonWithImages({int offset = 0, int limit = 25}) async {
    final listPokemonUrl = "$baseUrl/pokemon/?offset=$offset&limit=$limit";
    List<Results> resultsWithImages = [];

    try {
      final response = await http.get(Uri.parse(listPokemonUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> map = json.decode(response.body);
        final List<Results> results = (map['results'] as List)
            .map((item) => Results.fromJson(item))
            .toList();

        for (var result in results) {
          final imageResponse = await http.get(Uri.parse(result.url));
          if (imageResponse.statusCode == 200) {
            final imageMap = json.decode(imageResponse.body);
            result.imageUrl = imageMap['sprites']['front_default'];
          } else {
            throw Exception("Failed to load image data: ${imageResponse.statusCode}");
          }
        }

        resultsWithImages = results;

      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch data: $e");
    }
    return resultsWithImages;
  }

  // fetch detail pokemon
  Future<DetailPokemonModel> fetchDetailPokemon(String name) async {
    final detailPokemonUrl = "$baseUrl/pokemon/$name";

    try{
      final response = await http.get(Uri.parse(detailPokemonUrl));


      if(response.statusCode == 200){
        final Map<String,dynamic> map = json.decode(response.body);
        return DetailPokemonModel.fromJson(map);
      }else{
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Failed to fetch data: $e");
    }
  }

}