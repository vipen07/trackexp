import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:trackexp/Model/money.dart';
import 'package:trackexp/services/database.dart';
import 'package:trackexp/Model/MyUser.dart';
import 'package:intl/intl.dart';
class SeeAll extends StatefulWidget {
  const SeeAll({Key? key}) : super(key: key);

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {

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







          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context,index){
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset('assets/${transac[index].name!}.png'),
                  ),
                  title: Text(
                    transac[index].name!,
                    style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: Text(
                    transac[index].explain!,
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
                            fun(transac,index),
                            style:TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: transac[index].IN=='Expense'?Colors.red:Colors.green,
                            ),
                          ),
                          Text(
                            transac[index].dateTime!,
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
              childCount: transac.length-1,
            ),





          );

        }
      },
    );



  }
  String fun(List<money>transac,int index){
    return transac[index].IN=='Expense'?'-\$ ${transac[index].amount!}':'\$ ${transac[index].amount!}';
  }
}
