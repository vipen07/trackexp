import 'package:flutter/material.dart';
import 'package:trackexp/Screens/home/home.dart';

import 'package:trackexp/Screens/home/add.dart';
import 'package:trackexp/Screens/Statistics/pie_chart_page.dart';
import 'package:trackexp/Screens/Statistics/pie_chart_sections.dart';
import 'package:trackexp/Screens/Statistics/pie_data.dart';
import 'package:trackexp/Screens/Statistics/indicators_widget.dart';
import 'package:trackexp/Screens/Statistics/Stats.dart';
class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index_color=0;
  List Screen=[Home(),Stats()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Screen[index_color],
          floatingActionButton: FloatingActionButton(
            onPressed: (){
                index_color=1;
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Add_Screen()));
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(139, 125, 255, 0.98),
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: EdgeInsets.only(top:7.5,bottom: 7.5),
            child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    index_color=0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: index_color==0?Color.fromRGBO(139, 125, 255, 0.98):Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    index_color=1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: index_color==1?Color.fromRGBO(139, 125, 255, 0.98):Colors.grey,
                ),
              ),
              // SizedBox(width: 20,),
              // GestureDetector(
              //   onTap: (){
              //     setState(() {
              //       index_color=2;
              //     });
              //   },
              //   child: Icon(
              //     Icons.account_balance_wallet_outlined,
              //     size: 30,
              //     color: index_color==2?Color.fromRGBO(139, 125, 255, 0.98):Colors.grey,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: (){
              //     setState(() {
              //       index_color=3;
              //     });
              //   },
              //   child: Icon(
              //     Icons.person_outlined,
              //     size: 30,
              //     color: index_color==3?Color.fromRGBO(139, 125, 255, 0.98):Colors.grey,
              //   ),
              // ),
            ],
          )
          ),
        ),
    );
  }
}
