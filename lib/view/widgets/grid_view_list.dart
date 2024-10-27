import 'package:flutter/material.dart';
import 'package:pokemon_game/bloc/detail_pokemon_bloc.dart';
import 'package:pokemon_game/common/app_const.dart';
import 'package:pokemon_game/view/widgets/button_custom.dart';
import 'package:pokemon_game/view/widgets/pokemon_card.dart';
import '../../entities/detail_pokemon_model.dart';
import '../../entities/list_pokemon_model.dart';
import '../pages/detail_page.dart';

class GridViewList extends StatefulWidget {
  final List<Results> listResults;
  final bool isMultiSelect;
  final ScrollController scrollController;
  final Function(String, String, List<ListStats>, String, String, List<ListStats>)? onComparisonSelected;

  const GridViewList({super.key, required this.listResults, required this.isMultiSelect, this.onComparisonSelected, required this.scrollController});

  @override
  GridViewListState createState() => GridViewListState();
}

class GridViewListState extends State<GridViewList> {

  List<Results> selectedPokemons = [];
  List<ListStats>? stats1;
  List<ListStats>? stats2;

  void _toggleSelection(Results pokemon) {
    setState(() {
      if (selectedPokemons.contains(pokemon)) {
        selectedPokemons.remove(pokemon);
      } else {
        if (selectedPokemons.length < 2) {
          selectedPokemons.add(pokemon);
        }
      }
    });
  }

  void _compareSelectedPokemon(BuildContext context) {
    if (selectedPokemons.length == 2) {
      final firstPokemon = selectedPokemons[0];
      final secondPokemon = selectedPokemons[1];

      final detailPokemonBloc = DetailPokemonBloc();
      detailPokemonBloc.fetchDetailPokemon(firstPokemon.name);
      detailPokemonBloc.fetchDetailPokemon(secondPokemon.name);

      detailPokemonBloc.stream.listen((state) {
        if (state is DetailPokemonSuccessState) {
          if (state.detailPokemonModel.name == firstPokemon.name) {
            stats1 = state.detailPokemonModel.listStats;
          } else {
            stats2 = state.detailPokemonModel.listStats;
          }

          if (stats1 != null && stats2 != null) {
            widget.onComparisonSelected!(firstPokemon.name, firstPokemon.imageUrl ?? AppConst.defaultImage, stats1!, secondPokemon.name, secondPokemon.imageUrl ?? AppConst.defaultImage, stats2!);
            if(context.mounted)Navigator.of(context).pop();
          }
        } else if (state is DetailPokemonFailedState) {
          throw Exception(state.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.5;
    final double itemWidth = size.width / 2;

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [

            if(widget.isMultiSelect)...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Choose 2 Pokémon",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("${selectedPokemons.length}/2 selected"),
                ],
              ),
              const SizedBox(height: 16),
            ],
            Expanded(
              child: GridView.count(
                controller: widget.scrollController,
                crossAxisCount: 2,
                physics: const BouncingScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: (itemWidth / itemHeight),
                shrinkWrap: true,
                children: List.generate(
                  widget.listResults.length,
                      (index) {
                    final pokemon = widget.listResults[index];
                    final isSelected = selectedPokemons.contains(pokemon);

                    return GestureDetector(
                      onTap: () {
                        if (widget.isMultiSelect) {
                          _toggleSelection(pokemon);
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(name: widget.listResults[index].name)));
                        }
                      },
                      child: PokemonCard(
                        numberIndex: index,
                        results: widget.listResults,
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),

        // Show button if 2 Pokemon selected
        selectedPokemons.length == 2
            ? Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: buttonCustom("Let's Compare", (){_compareSelectedPokemon(context);})
        )
            : Container(),
      ],
    );
  }
}