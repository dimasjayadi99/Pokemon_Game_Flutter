import 'package:flutter/material.dart';
import 'package:pokemon_game/bloc/list_pokemon_bloc.dart';
import 'package:pokemon_game/entities/list_pokemon_model.dart';
import '../widgets/list_content.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ListPokemonBloc? listPokemonBloc;
  List<Results> listResults = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    listPokemonBloc = ListPokemonBloc();
    listPokemonBloc!.fetchListPokemon();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (listResults.length % listPokemonBloc!.limit == 0 &&
            listResults.length < listPokemonBloc!.offset + listPokemonBloc!.limit) {
          listPokemonBloc!.fetchListPokemon(isLoadMore: true);
        }
      }
    });
  }

  @override
  void dispose() {
    listPokemonBloc!.close();
    listResults.clear();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: listContent(listPokemonBloc: listPokemonBloc, listResults: listResults, scrollController: _scrollController, isMultiSelect: false)
      ),
    );
  }
}