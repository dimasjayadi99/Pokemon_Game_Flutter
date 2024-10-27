import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_game/api/api_service.dart';
import 'package:pokemon_game/entities/detail_pokemon_model.dart';

ApiService apiService = ApiService();

class DetailPokemonState{}

class DetailPokemonInitState extends DetailPokemonState{}

class DetailPokemonLoadingState extends DetailPokemonState{}

class DetailPokemonSuccessState extends DetailPokemonState{
  final DetailPokemonModel detailPokemonModel;
  DetailPokemonSuccessState({required this.detailPokemonModel});
}

class DetailPokemonFailedState extends DetailPokemonState{
  final String message;
  DetailPokemonFailedState({required this.message});
}

class DetailPokemonBloc extends Cubit<DetailPokemonState>{
  DetailPokemonBloc() : super(DetailPokemonInitState());

  Future<void> fetchDetailPokemon(String name) async {

    emit(DetailPokemonLoadingState());
    final response = await apiService.fetchDetailPokemon(name);

    try{
      emit(DetailPokemonSuccessState(detailPokemonModel: response));
    }catch(e){
      emit(DetailPokemonFailedState(message: e.toString()));
    }
  }

}