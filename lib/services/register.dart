import 'package:trackexp/services/auth.dart';
import 'package:trackexp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:trackexp/shared/constants.dart';

class Register extends StatefulWidget {
  final  toggleview;

  Register({required this.toggleview});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formkey=GlobalKey<FormState>();
  String email = '';
  String pass = ''; //to track what the user is typing
  String error='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(139, 125, 255, 0.98),
        elevation: 0.0,
        title: Text('Register to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: (){
              widget.toggleview();
            },
            icon: Icon(
              Icons.person,
              color: Colors.black87,
            ),
            label: Text('Sign in',
              style: TextStyle(
                  color: Colors.black87
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Color.fromRGBO(139, 125, 255, 0.98),
            ),
          )
        ],
      ),
      body: Container(
            decoration: BoxDecoration(
            color: Color.fromRGBO(203,187,249,0.98),
            ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 20.0),
                //for email
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email',),//constants.dart
                    validator: (val) => val!.isEmpty?'Enter an email':null,
                    onChanged: (val) {
                      email = val;
                    }
                ),
                SizedBox(height: 20.0),
                //for password
                TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),//constants.dart
                    validator: (val) => val!.length<6?'Enter a password 6+ chars long':null,
                    onChanged: (val) {
                      setState(() {
                        pass = val;
                      });
                    }
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                    ),
                    onPressed: () async {
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          loading=true;
                        });
                       dynamic result=await _auth.registerWithEmailAndPassword(email, pass);
                       if(result==null){
                         setState(() {
                           error='please supply a valid email';
                           loading=false;
                         });
                       }
                      }
                    },
                    child: Text('Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                ),
                SizedBox(height: 12.0,),
                Text(
                    error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize:14.0,
                  ),
                )

              ],
            ),
          )
      ),
    );
  }
}
