import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_game/view/widgets/shimmer_effect.dart';
import '../../bloc/list_pokemon_bloc.dart';
import '../../entities/detail_pokemon_model.dart';
import '../../entities/list_pokemon_model.dart';
import 'grid_view_list.dart';

Widget listContent({
  required ListPokemonBloc? listPokemonBloc,
  required List<Results> listResults,
  required ScrollController scrollController,
  required bool isMultiSelect,
  List<ListStats>? stats1,
  List<ListStats>? stats2,
  String? firstPokemonName,
  String? secondPokemonName,
  String? firstPokemonImage,
  String? secondPokemonImage,
  Function(String, String, List<ListStats>, String, String, List<ListStats>)? onUpdate,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: BlocBuilder<ListPokemonBloc, ListPokemonState>(
      bloc: listPokemonBloc,
      builder: (context, state) {
        if (state is ListPokemonLoadingState && listResults.isEmpty) {
          return shimmerEffect();
        }

        listResults = (state is ListPokemonSuccessState) ? state.results : listResults;

        return Column(
          children: [
            Expanded(
              child: GridViewList(
                listResults: listResults,
                isMultiSelect: isMultiSelect,
                scrollController: scrollController,
                onComparisonSelected: (firstPokemon, firstPokemonImageUrl, selectedStats1, secondPokemon, secondPokemonImageUrl, selectedStats2) {
                  onUpdate!(firstPokemon, firstPokemonImageUrl, selectedStats1, secondPokemon, secondPokemonImageUrl, selectedStats2);
                },
              ),
            ),
            if (state is ListPokemonLoadingMoreState)
              const CircularProgressIndicator(),
            if (state is ListPokemonFailedState)
              Center(child: Text(state.message, textAlign: TextAlign.center)),
          ],
        );
      },
    ),
  );
}
