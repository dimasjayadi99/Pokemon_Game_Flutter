import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_game/utils/text_formatter.dart';
import 'package:pokemon_game/view/widgets/button_custom.dart';
import 'package:pokemon_game/view/widgets/detail_image.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../bloc/list_pokemon_bloc.dart';
import '../../entities/detail_pokemon_model.dart';
import '../../entities/list_pokemon_model.dart';
import '../widgets/list_content.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({super.key});

  @override
  ComparePageState createState() => ComparePageState();
}

class ComparePageState extends State<ComparePage> {
  ListPokemonBloc? listPokemonBloc;
  List<Results> listResults = [];
  bool isSelected = false;
  List<ListStats> stats1 = [];
  List<ListStats> stats2 = [];
  String firstPokemonName = "";
  String secondPokemonName = "";
  String firstPokemonImage = "";
  String secondPokemonImage = "";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
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
    super.initState();
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
        child: Column(
          children: [
            Expanded(
              child: stats1.isEmpty || stats2.isEmpty
                  ? const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.compare,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please select 2 Pokemon first\nbefore comparing",
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
                  : Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DetailImage().buildImageCard(context, firstPokemonName, firstPokemonImage, 'Several Version'),
                      DetailImage().buildImageCard(context, secondPokemonName, secondPokemonImage, 'Several Version'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SfCartesianChart(
                    primaryXAxis: const CategoryAxis(
                      labelRotation: 45,
                      labelsExtent: 60,
                    ),
                    primaryYAxis: const NumericAxis(
                      labelFormat: '{value}',
                      interval: 20,
                    ),
                    series: <CartesianSeries<ListStats, String>>[
                      ColumnSeries<ListStats, String>(
                        dataSource: stats1,
                        xValueMapper: (ListStats stat, _) => stat.stat.name,
                        yValueMapper: (ListStats stat, _) => stat.baseStat,
                        dataLabelSettings: const DataLabelSettings(isVisible: true),
                        name: TextFormatter().capitalize(firstPokemonName),
                        color: Colors.blue,
                      ),
                      ColumnSeries<ListStats, String>(
                        dataSource: stats2,
                        xValueMapper: (ListStats stat, _) => stat.stat.name,
                        yValueMapper: (ListStats stat, _) => stat.baseStat,
                        dataLabelSettings: const DataLabelSettings(isVisible: true),
                        name: TextFormatter().capitalize(secondPokemonName),
                        color: Colors.red,
                      ),
                    ],
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      format: 'point.x\nValue: point.y',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  if (stats1.isNotEmpty && stats2.isNotEmpty) ...[
                    Expanded(child: buttonCustom("Clear Data", () {
                      setState(() {
                        firstPokemonName = "";
                        secondPokemonName = "";
                        firstPokemonImage = "";
                        secondPokemonImage = "";
                        stats1.clear();
                        stats2.clear();
                      });
                    })),
                    const SizedBox(width: 10),
                    Expanded(child: buttonCustom("Select Another", () {
                      _showPokemonList(context);
                    })),
                  ] else ...[
                    Expanded(child: buttonCustom("Choose 2 Pokemon", () {
                      _showPokemonList(context);
                    })),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPokemonList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: listPokemonBloc!,
          child: listContent(
            listPokemonBloc: listPokemonBloc,
            listResults: listResults,
            scrollController: _scrollController,
            stats1: stats1,
            stats2: stats2,
            firstPokemonName: firstPokemonName,
            secondPokemonName: secondPokemonName,
            firstPokemonImage: firstPokemonImage,
            secondPokemonImage: secondPokemonImage,
            onUpdate: (firstName, firstImage, stat1, secondName, secondImage, stat2) {
              setState(() {
                firstPokemonName = firstName;
                firstPokemonImage = firstImage;
                stats1 = stat1;
                secondPokemonName = secondName;
                secondPokemonImage = secondImage;
                stats2 = stat2;
              });
            },
            isMultiSelect: true,
          ),
        );
      },
    );
  }
}

