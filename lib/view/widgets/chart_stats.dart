import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../entities/detail_pokemon_model.dart';

Widget chartStats(DetailPokemonModel detailPokemonModel) {

  return SfCartesianChart(
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
        name: "Pokemon",
        dataSource: detailPokemonModel.listStats.map((stat) {
          return ListStats(baseStat: stat.baseStat, stat: stat.stat);
        }).toList(),
        xValueMapper: (ListStats stat, _) => stat.stat.name,
        yValueMapper: (ListStats stat, _) => stat.baseStat,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        color: Colors.blue,
      )
    ],
    tooltipBehavior: TooltipBehavior(
      enable: true,
      format: 'point.x\nValue: point.y',
    ),
  );
}