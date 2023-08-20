import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:trackexp/Model/money.dart';
import 'package:trackexp/services/database.dart';
import 'package:trackexp/Model/MyUser.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:trackexp/services/auth.dart';
import 'package:trackexp/Screens/home/add.dart';
import 'package:trackexp/shared/loading.dart';
class Head extends StatefulWidget {
  const Head({Key? key}) : super(key: key);

  @override
  State<Head> createState() => _HeadState();
}
List<money>list_data=[];
class _HeadState extends State<Head> {
  List<String>names=['Soldier','Iron Man','Thor','Batman','Captain','Hulk','Hawkeye'];
  int val=0;
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<MyUser?>(context);
    return StreamBuilder<QuerySnapshot> (
        stream: DatabaseService(uid: user!.uid).transac,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {

    return  Text('Something went wrong');

    }

    if (snapshot.connectionState == ConnectionState.waiting) {
    val=Random().nextInt(names.length);
    return Stack(
        children: [
          Column(
              children:[
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(203,187,249,0.98),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 35,
                        left: 350,
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(7),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Color.fromRGBO(222,202,255,0.98),
                            child: IconButton(
                              onPressed: ()async{
                                await _auth.signOut();


                              },
                              icon:Icon(Icons.logout_outlined),
                              color: Colors.white,
                            ),

                          ),
                        ),
                      ),

                      Padding(//Good Afternoon
                          padding: EdgeInsets.only(left:10 ,top: 35),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Have a nice day! ',
                                  style:TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color:Color.fromARGB(255, 224,223, 223)
                                  )
                              ),
                              Text(
                                  names[val],
                                  style:TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color:Colors.white
                                  )
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ]
          ),
          Positioned(//Total Balance,Income,Expense Box
              top: 140,
              left: 37,
              child: Container(
                height: 170,
                width: 320,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(139, 125, 255, 0.98),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(191, 178, 255, 0.9),
                        offset: Offset(0,6),
                        blurRadius: 12,
                        spreadRadius: 6,

                      )
                    ]
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal:15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Total Balance',
                                style:TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color:Colors.white
                                )
                            ),
                            Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 7),
                    Padding(
                        padding: EdgeInsets.only(left:15),
                        child:Row(
                          children: [
                            Text(
                              '\$...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            )
                          ],

                        )
                    ),
                    SizedBox(height: 25),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal:15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                children: [
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundColor:  Color.fromRGBO(168,154,255,0.98),
                                    child: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.white,
                                      size: 19,
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 216, 216, 216),
                                    ),
                                  )
                                ]
                            ),
                            Row(
                                children: [
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundColor:  Color.fromRGBO(168,154,255,0.98),
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                      size: 19,
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    'Expense',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 216, 216, 216),
                                    ),
                                  )
                                ]
                            ),
                          ],

                        )
                    ),
                    SizedBox(height: 6),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal:30),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ...',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Colors.white,
                              ) ,
                            ),
                            Text(
                              '\$ ...',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Colors.white,
                              ) ,
                            ),
                          ],
                        )
                    ),

                  ],
                ),
              )
          )
        ]
    );


    }
    else {
    List<money>transac=DatabaseService(uid: user!.uid).transacListFromSnapshot(snapshot);
    transac.sort((a, b){ //sorting in descending order
    return DateTime.parse(b.dateTime).compareTo(DateTime.parse(a.dateTime));
    });

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
    val=Random().nextInt(names.length);
    return Stack(
    children: [
    Column(
    children:[
    Container(
    width: double.infinity,
    height: 240,
    decoration: BoxDecoration(
    color: Color.fromRGBO(203,187,249,0.98),
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
    ),
    ),
    child: Stack(
    children: [
    Positioned(
    top: 35,
    left: 350,
    child: ClipRRect(
    borderRadius:BorderRadius.circular(7),
    child: Container(
    height: 40,
    width: 40,
    color: Color.fromRGBO(222,202,255,0.98),
    child: IconButton(
    onPressed: ()async{
     await _auth.signOut();


    },
    icon:Icon(Icons.logout_outlined),
    color: Colors.white,
    ),

    ),
    ),
    ),

    Padding(//Good Afternoon
    padding: EdgeInsets.only(left:10 ,top: 35),
    child:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Have a nice day! ',
    style:TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color:Color.fromARGB(255, 224,223, 223)
    )
    ),
    Text(
    names[val],
    style:TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color:Colors.white
    )
    ),
    ],
    )
    ),
    ],
    ),
    ),
    ]
    ),
    Positioned(//Total Balance,Income,Expense Box
    top: 140,
    left: 37,
    child: Container(
    height: 170,
    width: 320,
    decoration: BoxDecoration(
    color: Color.fromRGBO(139, 125, 255, 0.98),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
    BoxShadow(
    color: Color.fromRGBO(191, 178, 255, 0.9),
    offset: Offset(0,6),
    blurRadius: 12,
    spreadRadius: 6,

    )
    ]
    ),
    child: Column(
    children: [
    SizedBox(height: 10),
    Padding(
    padding: EdgeInsets.symmetric(horizontal:15),
    child:Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'Total Balance',
    style:TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color:Colors.white
    )
    ),
    Icon(
    Icons.more_horiz,
    color: Colors.white,
    ),
    ],
    )
    ),
    SizedBox(height: 7),
    Padding(
    padding: EdgeInsets.only(left:15),
    child:Row(
    children: [
    Text(
    total_income()-total_expense()>=0?'\$ ${total_income()-total_expense()}':'-\$ ${total_expense()-total_income()}',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: Colors.white,
    ),
    )
    ],

    )
    ),
    SizedBox(height: 25),
    Padding(
    padding: EdgeInsets.symmetric(horizontal:15),
    child:Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Row(
    children: [
    CircleAvatar(
    radius: 13,
    backgroundColor:  Color.fromRGBO(168,154,255,0.98),
    child: Icon(
    Icons.arrow_downward,
    color: Colors.white,
    size: 19,
    ),
    ),
    SizedBox(width: 7),
    Text(
    'Income',
    style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Color.fromARGB(255, 216, 216, 216),
    ),
    )
    ]
    ),
    Row(
    children: [
    CircleAvatar(
    radius: 13,
    backgroundColor:  Color.fromRGBO(168,154,255,0.98),
    child: Icon(
    Icons.arrow_upward,
    color: Colors.white,
    size: 19,
    ),
    ),
    SizedBox(width: 7),
    Text(
    'Expense',
    style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Color.fromARGB(255, 216, 216, 216),
    ),
    )
    ]
    ),
    ],

    )
    ),
    SizedBox(height: 6),
    Padding(
    padding: EdgeInsets.symmetric(horizontal:30),
    child:Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    '\$ ${total_income()}',
    style: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
    color: Colors.white,
    ) ,
    ),
    Text(
    '\$ ${total_expense()}',
    style: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
    color: Colors.white,
    ) ,
    ),
    ],
    )
    ),

    ],
    ),
    )
    )
    ]
    );
    };

    }

  );
  }

}
double total_expense(){
  double total_value = 0;
  List<money>moneyList = list_data;

  for (var Money in moneyList) {

    int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
    if (Money.IN == 'Expense') {
      total_value += amount!;
    }
  }
  return total_value;
}
double total_income(){
  double total_value = 0;
  List<money>moneyList = list_data;

  for (var Money in moneyList) {

    int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
    if (Money.IN == 'Income') {
      total_value += amount!;
    }
  }
  return total_value;
}