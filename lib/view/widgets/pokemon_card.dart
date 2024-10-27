import 'package:flutter/material.dart';
import 'package:pokemon_game/entities/list_pokemon_model.dart';
import 'package:pokemon_game/utils/text_formatter.dart';

import '../../common/app_const.dart';

class PokemonCard extends StatelessWidget{

  final List<Results> results;
  final int numberIndex;
  final bool isSelected;

  const PokemonCard({super.key, required this.numberIndex, required this.results, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
        child: Stack(children: [
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    (numberIndex + 1).toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Pokemon image
              Center(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      results[numberIndex].imageUrl ?? AppConst.defaultImage,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 16),
                    Text(TextFormatter().capitalize(results[numberIndex].name))
                  ],
                ),
              ),
            ],),
    );
  }

}