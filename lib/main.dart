import 'package:trackexp/Screens/wrapper.dart';
import 'package:trackexp/Model/MyUser.dart';
import 'package:trackexp/services/auth.dart';
import 'package:trackexp/services/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:trackexp/services/register.dart';
Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //type of data we're listening from the stream
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,//name of the stream that it'll listen
      child: MaterialApp(

        home: wrapper(),
      ),
    );
  }
}
