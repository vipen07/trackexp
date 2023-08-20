import 'package:trackexp/Screens/authenticate/authenticate.dart';
import 'package:trackexp/Screens/home/home.dart';
import 'package:trackexp/Model/MyUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackexp/widgets/bottomnavigator.dart';
import 'package:trackexp/Screens/home/add.dart';
class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user= Provider.of<MyUser?>(context);
    //return either home or authenticate widget
    if(user==null){
      return Authenticate();
    }
    else{
      return Bottom();
    }
  }
}
