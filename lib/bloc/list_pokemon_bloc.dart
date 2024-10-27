import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_game/api/api_service.dart';
import 'package:pokemon_game/entities/list_pokemon_model.dart';

ApiService _apiService = ApiService();

abstract class ListPokemonState {}

class ListPokemonInitialState extends ListPokemonState {}

class ListPokemonLoadingState extends ListPokemonState {}

class ListPokemonLoadingMoreState extends ListPokemonState {}

class ListPokemonSuccessState extends ListPokemonState {
  final List<Results> results;
  ListPokemonSuccessState({required this.results});
}

class ListPokemonFailedState extends ListPokemonState {
  final String message;
  ListPokemonFailedState({required this.message});
}

class ListPokemonBloc extends Cubit<ListPokemonState> {
  int offset = 0;
  final int limit = 25;
  List<Results> allResults = [];
  bool isLoadingMore = false;

  ListPokemonBloc() : super(ListPokemonInitialState());

  Future<void> fetchListPokemon({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoadingMore) return;
      isLoadingMore = true;
      emit(ListPokemonLoadingMoreState());
    } else {
      emit(ListPokemonLoadingState());
      offset = 0;
      allResults.clear();
    }

    try {
      final response = await _apiService.fetchListPokemonWithImages(offset: offset, limit: limit);

      if (response.isNotEmpty) {
        allResults.addAll(response);
        emit(ListPokemonSuccessState(results: allResults));
        offset += limit;
      } else {
        emit(ListPokemonFailedState(message: "Data tidak tersedia"));
      }
    } catch (error) {
      emit(ListPokemonFailedState(message: "$error"));
    } finally {
      isLoadingMore = false;
    }
  }
}
