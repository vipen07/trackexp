import 'package:flutter/material.dart';
import 'package:trackexp/Model/listdata.dart';
import 'package:trackexp/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackexp/Model/MyUser.dart';
import 'package:trackexp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:trackexp/Model/listdata.dart';
import 'package:trackexp/Model/money.dart';
import 'package:trackexp/Model/listdata_yesterday.dart';
import 'package:trackexp/Model/listdata_past.dart';
import 'See_All.dart';
import 'package:trackexp/Screens/Statistics/pie_data.dart';
import 'package:trackexp/Screens/Statistics/pie_income_data.dart';
import 'package:trackexp/services/sign_in.dart';
import 'package:trackexp/Screens/authenticate/authenticate.dart';
import 'package:trackexp/widgets/head.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {

    final user= Provider.of<MyUser?>(context);
    return Scaffold(
       body: SafeArea(
        child:CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: SizedBox(height: 340,child:Head()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transaction History',
                      style:TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                          color:Colors.black,

                      ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>See_All()));
                        },
                      child: Text('See all',
                              style:TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color:Colors.grey,
                    ),
                  ))
                ],
              ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child:Divider(
                height: 10.0,
                color: Colors.deepPurple,
                thickness: 2.0,
              ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Today',
                      style:TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                        color:Colors.black,

                      ),
                    ),

                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            TransacList(),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child:Divider(
                  height: 10.0,
                  color: Colors.deepPurple,
                  thickness: 2.0,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Yesterday',
                  style:TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    color:Colors.black,
                  ),
                ),

              ],
            ),
          ),
        ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            TransacListYesterday(),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child:Divider(
                  height: 10.0,
                  color: Colors.deepPurple,
                  thickness: 2.0,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Past',
                      style:TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                        color:Colors.black,
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            TransacListPast(),
          ],
        )
      ),



    );
  }


}
