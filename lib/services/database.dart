import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackexp/Model/money.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class DatabaseService{
  final String uid;
  DatabaseService({required this.uid});
  //collection reference
  final CollectionReference transacCollection=FirebaseFirestore.instance.collection('users');

  Future SetUserData(String name,String explain,String amount,String IN,DateTime dateTime)async{
    money m=money();
    m.name=name;
    m.amount=amount;
    m.explain=explain;
    m.IN=IN;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    m.dateTime=formatted;


    return await transacCollection.doc(uid).collection('transac').add({
      'name':m.name,
      'amount': m.amount,
      'explain':m.explain,
      'IN':m.IN,
      'dateTime':m.dateTime,
    });
  }

  // Future updateUserData(money m)async{
  //   return await transacCollection.doc(uid).update({
  //     'listdata': FieldValue.arrayUnion([m]),
  //   });
  // }

  //transaction list from snapshot
   List<money> transacListFromSnapshot(AsyncSnapshot<QuerySnapshot> snapshot){
      return  snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> doc = document.data()! as Map<String, dynamic>;
         money m = money();
         m.name = doc['name'] ?? '';
         m.amount = doc['amount'] ?? '';
         m.explain = doc['explain'] ?? '';
         m.IN = doc['IN'] ?? '';
         m.dateTime = doc['dateTime'];
         return m;
       }).toList();

  }

  Stream<QuerySnapshot> get transac{
    return transacCollection.doc(uid).collection('transac').snapshots();
  }

}