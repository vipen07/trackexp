import 'package:trackexp/services/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:trackexp/services/register.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  toggleView() {

    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleview:toggleView);
    }
    else{
      return Register(toggleview:toggleView);
    }
  }
}
