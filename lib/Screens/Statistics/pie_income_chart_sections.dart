import 'package:fl_chart/fl_chart.dart';
import 'pie_income_data.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> getSections(int touchedIndex) => PieData.getIncomeList()
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
  final isTouched = index == touchedIndex;
  final double fontSize = isTouched ? 25 : 16;
  final double radius = isTouched ? 100 : 80;

  final value = PieChartSectionData(
    color: data.color,
    value: data.percent,
    title: '${data.percent}%',
    radius: radius,
    titleStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: const Color(0xffca1d1d),
    ),
  );

  return MapEntry(index, value);
})
    .values
    .toList();