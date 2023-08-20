import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:trackexp/Model/money.dart';
import 'package:trackexp/services/database.dart';
import 'package:trackexp/Model/MyUser.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
class TransacList extends StatefulWidget {
  const TransacList({Key? key}) : super(key: key);

  @override
  State<TransacList> createState() => _TransacListState();
}
List<money>list_data=[];//List of current month Transactions

class _TransacListState extends State<TransacList> {

  @override
  Widget build(BuildContext context) {

    final user= Provider.of<MyUser?>(context);
     return  StreamBuilder<QuerySnapshot> (
       stream: DatabaseService(uid: user!.uid).transac,
       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
         if (snapshot.hasError) {

           return SliverToBoxAdapter(
             child: Text('Something went wrong'),
           );
         }

         if (snapshot.connectionState == ConnectionState.waiting) {
           return SliverToBoxAdapter(
             child: Text('loading'),
           );
         }
        else {
           List<money>transac=DatabaseService(uid: user!.uid).transacListFromSnapshot(snapshot);
          transac.sort((a, b){ //sorting in descending order
            return DateTime.parse(b.dateTime).compareTo(DateTime.parse(a.dateTime));
          });
          //Today date
          DateTime dateTime1=DateTime.now();
          final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
          final String formatted1 = formatter1.format(dateTime1);
          String today_date=formatted1;

          List<money>today=[];



          for(int i=0;i<transac.length;i++){
            if(transac[i].dateTime==today_date){
              today.add(transac[i]);
            }

          }
            //current month
          DateTime dateTime2=DateTime.now();
          final DateFormat formatter2 = DateFormat('MM');
          final String formatted2 = formatter2.format(dateTime2);
          String curr_month=formatted2;
          print(curr_month);
          //current year
          DateTime dateTime3=DateTime.now();
          final DateFormat formatter3 = DateFormat.y();
          final String formatted3 = formatter3.format(dateTime3);
          String curr_year=formatted3;
          print(curr_year);
          list_data.clear();
          for(int i=0;i<transac.length;i++){

              print(transac[i].dateTime.substring(0,4));
              print(transac[i].name);
              if((transac[i].dateTime.substring(5,7)==curr_month)&&(transac[i].dateTime.substring(0,4)==curr_year)){
                list_data.add(transac[i]);
              }


          }

          return SliverList(
             delegate: SliverChildBuilderDelegate(
                   (context,index){
                 return ListTile(
                   leading: ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Image.asset('assets/${today[index].name!}.png'),
                   ),
                   title: Text(
                     today[index].name!,
                     style:TextStyle(
                       fontWeight: FontWeight.w600,
                       fontSize: 17,
                     ),
                   ),
                   subtitle: Text(
                     today[index].explain!,
                     style:TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w600,

                     ),
                   ),
                   trailing:Container(
                     padding: EdgeInsets.all(8),
                   child:Column(
                   children:[
                     Text(
                     fun(today,index),
                     style:TextStyle(
                       fontWeight: FontWeight.w600,
                       fontSize: 19,
                       color: today[index].IN=='Expense'?Colors.red:Colors.green,
                     ),
                   ),
                     Text(
                       today[index].dateTime!,
                       style:TextStyle(
                         fontSize: 14,
                         fontWeight: FontWeight.w400,

                       ),
                     ),
                     ]
                   ),
                 ),
                 );
               },
               childCount: today.length,
             ),





         );

         }
       },
     );



  }
 String fun(List<money>today,int index){
    return today[index].IN=='Expense'?'-\$ ${today[index].amount!}':'\$ ${today[index].amount!}';
 }
}
