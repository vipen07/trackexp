import 'package:fl_chart/fl_chart.dart';
import 'indicators_widget.dart';
import 'pie_chart_sections.dart';
import 'package:flutter/material.dart';

class PieChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartPageState();
}

class PieChartPageState extends State {
  int touchedIndex=-1;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      children: <Widget>[

         Expanded(
           flex: 2,
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
        Expanded(
          flex: 1,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: IndicatorsWidget(),
            ),

          ],
        ),
        ),
      ],
    ),
  );
}