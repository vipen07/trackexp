import 'package:fl_chart/fl_chart.dart';
import 'pie_income_indicator.dart';
import 'pie_income_chart_sections.dart';
import 'package:flutter/material.dart';

class PieIncomeChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieIncomeChartPageState();
}

class PieIncomeChartPageState extends State {
  int touchedIndex=-1;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      children: <Widget>[
        Expanded(
          child: PieChart(
            PieChartData(
              // pieTouchData: PieTouchData(
              //   touchCallback: (PieTouchResponse){
              //     setState(() {
              //       if (PieTouchResponse!.touchInput is FlLongPressEnd ||
              //           PieTouchResponse!.touchInput is FlPanEnd) {
              //         touchedIndex = -1;
              //       } else {
              //         touchedIndex = PieTouchResponse!.touchedSectionIndex;
              //       }
              //     });
              //   },
              // ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 30,
              sections: getSections(touchedIndex),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: IncomeIndicatorsWidget(),
            ),
          ],
        ),
      ],
    ),
  );
}