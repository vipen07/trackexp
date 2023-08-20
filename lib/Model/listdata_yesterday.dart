import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:trackexp/Model/money.dart';
import 'package:trackexp/services/database.dart';
import 'package:trackexp/Model/MyUser.dart';
import 'package:intl/intl.dart';
class TransacListYesterday extends StatefulWidget {
  const TransacListYesterday({Key? key}) : super(key: key);

  @override
  State<TransacListYesterday> createState() => _TransacListYesterdayState();
}

class _TransacListYesterdayState extends State<TransacListYesterday> {

  @override
  Widget build(BuildContext context) {

    final user= Provider.of<MyUser?>(context);
    return  StreamBuilder<QuerySnapshot>(
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

          //Yesterday
          DateTime dateTime2=DateTime.now().subtract(Duration(days:1));
          final DateFormat formatter2 = DateFormat('yyyy-MM-dd');
          final String formatted2 = formatter2.format(dateTime2);
          String yesterday_date=formatted2;

          List<money>yesterday=[];

          for(int i=0;i<transac.length;i++){

            if(transac[i].dateTime==yesterday_date){
              yesterday.add(transac[i]);
            }

          }

          return SliverList(
        delegate: SliverChildBuilderDelegate(
        (context,index){
        return ListTile(
        leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('assets/${yesterday[index].name!}.png'),
        ),
        title: Text(
        yesterday[index].name!,
        style:TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17,
        ),
        ),
        subtitle: Text(
        yesterday[index].explain!,
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
        fun(yesterday,index),
        style:TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 19,
        color: yesterday[index].IN=='Expense'?Colors.red:Colors.green,
        ),
        ),
        Text(
        yesterday[index].dateTime!,
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
        childCount: yesterday.length,
        ),





        );

      }
      },
    );



  }
  String fun(List<money>yesterday,int index){
    return yesterday[index].IN=='Expense'?'-\$ ${yesterday[index].amount!}':'\$ ${yesterday[index].amount!}';
  }
}
