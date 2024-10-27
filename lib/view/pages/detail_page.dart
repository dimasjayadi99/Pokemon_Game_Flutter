import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_game/bloc/detail_pokemon_bloc.dart';
import 'package:pokemon_game/entities/detail_pokemon_model.dart';
import 'package:pokemon_game/view/widgets/chart_stats.dart';
import 'package:pokemon_game/view/widgets/detail_image.dart';

import '../../common/app_const.dart';
import '../../utils/text_formatter.dart';

class DetailPage extends StatefulWidget {

  final String name;

  const DetailPage({super.key, required this.name});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {

  DetailPokemonBloc? detailPokemonBloc;
  DetailPokemonModel? detailPokemonModel;

  @override
  void initState() {
    detailPokemonBloc = DetailPokemonBloc();
    super.initState();
  }

  @override
  void dispose() {
    detailPokemonBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => detailPokemonBloc!..fetchDetailPokemon(widget.name),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Detail Pokemon"),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: BlocBuilder<DetailPokemonBloc, DetailPokemonState>(
            buildWhen: (context, state) => state is DetailPokemonLoadingState || state is DetailPokemonSuccessState || state is DetailPokemonFailedState,
            builder: (context, state){
              if(state is DetailPokemonLoadingState){
                return const Center(child: CircularProgressIndicator());
              }else if(state is DetailPokemonSuccessState){
                detailPokemonModel = state.detailPokemonModel;
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Pokemon image
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DetailImage().buildImageCard(context, detailPokemonModel!.name, detailPokemonModel!.sprites.frontDefault, "Several Version"),
                            DetailImage().buildImageCard(context, detailPokemonModel!.name, detailPokemonModel!.sprites.other.dreamWorld.frontDefault, "DreamWorld Version"),
                          ],
                        ),

                        // Pokemon information : height, weight and type
                        const SizedBox(height: 20),
                        _buildInfo(detailPokemonModel!),
                        const Divider(height: 30),

                        // Pokemon Stats
                        const Text(
                          "Statistik",
                          style: AppConst.titleStyle,
                        ),
                        const SizedBox(height: 10),
                        chartStats(detailPokemonModel!),
                        const Divider(height: 30),

                        // Pokémon Abilities
                        const Text(
                          "Abilities",
                          style: AppConst.titleStyle,
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: detailPokemonModel!.listAbilities.length,
                          itemBuilder: (context, index) {
                            final ability = detailPokemonModel!.listAbilities[index].ability;
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: Icon(Icons.star, color: detailPokemonModel!.listAbilities[index].isHidden ? Colors.yellow.shade400 : Colors.blue.shade400), // Ikon menarik
                                title: Text(
                                  TextFormatter().capitalize(ability.name),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              }else if(state is DetailPokemonFailedState){
                return Center(child: Text(state.message, textAlign: TextAlign.center));
              }else{
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(DetailPokemonModel detailPokemonModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoColumn("Weight", "${detailPokemonModel.weight} kg"),
          _buildInfoColumn("Height", "${detailPokemonModel.height} cm"),
          _buildInfoColumn("Types", detailPokemonModel.listTypes[0].type.name),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}