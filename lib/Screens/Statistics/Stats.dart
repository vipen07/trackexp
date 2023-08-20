import 'package:flutter/material.dart';
import 'package:trackexp/Screens/Statistics/pie_chart_page.dart';
import 'package:trackexp/Screens/Statistics/pie_chart_sections.dart';
import 'package:trackexp/Screens/Statistics/pie_data.dart';
import 'package:trackexp/Screens/Statistics/indicators_widget.dart';
import 'package:trackexp/Screens/Statistics/pie_income_chart_page.dart';
import 'package:trackexp/Screens/Statistics/pie_income_chart_sections.dart';
import 'package:trackexp/Screens/Statistics/pie_income_data.dart';
import 'package:trackexp/Screens/Statistics/pie_income_indicator.dart';
import 'package:trackexp/Screens/home/home.dart';
class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  int index_color=0;
  List Screen=[PieChartPage(),PieIncomeChartPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     GestureDetector(
                        onTap: (){
                          setState(() {
                            index_color=0;
                          });
                        },
                        child: Container(
                          width: 190,
                          height: 50,

                          decoration: BoxDecoration(
                            color: index_color==0?Color.fromRGBO(139, 125, 255, 0.98):Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child:Center(
                            child:Text(
                            'Expense',

                            style:TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                              color:Colors.black,
                            ),
                          ),
                          ),
                        )
                    ),

                     GestureDetector(
                        onTap: (){
                          setState(() {
                            index_color=1;
                          });
                        },
                        child: Container(
                          width: 190,
                          height: 50,
                          decoration: BoxDecoration(
                            color: index_color==1?Color.fromRGBO(139, 125, 255, 0.98):Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                          child:Text(
                            'Income',

                            style:TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                              color:Colors.black,
                            ),
                          ),
                     ),
                        )
                    ),


                  ],
                ),
              ),
            ),
            Container(

            height: 450,
            child:Screen[index_color],
            )
          ],
        ),
      ),
    );
  }
}
