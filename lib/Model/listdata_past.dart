import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:trackexp/Model/money.dart';
import 'package:trackexp/services/database.dart';
import 'package:trackexp/Model/MyUser.dart';
import 'package:intl/intl.dart';
class TransacListPast extends StatefulWidget {
  const TransacListPast({Key? key}) : super(key: key);

  @override
  State<TransacListPast> createState() => _TransacListPastState();
}

class _TransacListPastState extends State<TransacListPast> {

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
          //Today date
          DateTime dateTime1=DateTime.now();
          final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
          final String formatted1 = formatter1.format(dateTime1);
          String today_date=formatted1;
          //Yesterday
          DateTime dateTime2=DateTime.now().subtract(Duration(days:1));
          final DateFormat formatter2 = DateFormat('yyyy-MM-dd');
          final String formatted2 = formatter2.format(dateTime2);
          String yesterday_date=formatted2;


          List<money>past=[];
          for(int i=0;i<transac.length;i++){
            if(transac[i].dateTime!=today_date&&transac[i].dateTime!=yesterday_date){
              past.add(transac[i]);
            }

          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context,index){
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset('assets/${past[index].name!}.png'),
                  ),
                  title: Text(
                    past[index].name!,
                    style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: Text(
                    past[index].explain!,
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
                            fun(past,index),
                            style:TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: past[index].IN=='Expense'?Colors.red:Colors.green,
                            ),
                          ),
                          Text(
                            past[index].dateTime!,
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
              childCount: past.length-1,
            ),





          );

        }
      },
    );



  }
  String fun(List<money>past,int index){
    return past[index].IN=='Expense'?'-\$ ${past[index].amount!}':'\$ ${past[index].amount!}';
  }
}
