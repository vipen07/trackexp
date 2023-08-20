import 'package:flutter/material.dart';
import 'package:trackexp/Model/MyUser.dart';
import 'package:provider/provider.dart';
import 'package:trackexp/services/database.dart';
import 'package:trackexp/Screens/home/home.dart';
import 'package:trackexp/services/auth.dart';
import 'package:trackexp/widgets/bottomnavigator.dart';
class Add_Screen extends StatefulWidget {
  const Add_Screen({Key? key}) : super(key: key);

  @override
  State<Add_Screen> createState() => _Add_ScreenState();
}

class _Add_ScreenState extends State<Add_Screen> {

  final _formKey=GlobalKey<FormState>();
  DateTime date=DateTime.now();
  String selectedItem='';
  String selectedItemi='';
  String exp='';
  String fee='';
  final TextEditingController explain_C=TextEditingController();
  FocusNode ex=FocusNode();
  final TextEditingController amount_C=TextEditingController();
  FocusNode amount=FocusNode();
  bool _validateAmount = false;
  final List<String> _item=[
    'Food',
    'Transfer',
    'Transportation',
    'Education',
    'Salary',
    'Passive Income',
  ];
  final List<String> _itemi=[
    'Income',
    'Expense',
  ];
  @override
  void initState(){
    super.initState();
    ex.addListener(() {
      setState(() {
      exp=explain_C.text;
      });
    });
    amount.addListener(() {
      setState(() {
        fee=amount_C.text;
      });
    });
  }
  Widget build(BuildContext context) {
    final user= Provider.of<MyUser?>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
              _backgroundcontainer(),
            Positioned(
              top: 120,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                height: 550,
                width: 340,
                child: Form(
                  key: _formKey,
                  child:Column(

                    children: [
                      SizedBox(height: 50,),
                      name(),
                      SizedBox(height: 30,),
                      explain(),
                      SizedBox(height: 30,),
                      _amount(),
                      SizedBox(height: 30,),
                      How(),
                      SizedBox(height: 30,),
                      date_time(),
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            amount_C.text.isEmpty ? _validateAmount = true : _validateAmount = false;
                          });
                             if(_validateAmount==false) {
                               DatabaseService(uid: user!.uid).SetUserData(
                                   selectedItem, exp, fee, selectedItemi, date);
                               Navigator.of(context).pushReplacement(
                                   MaterialPageRoute(
                                       builder: (BuildContext context) {

                                         return Bottom();
                                       }));
                             }

                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromRGBO(222,202,255,0.98),
                          ),
                          width:120,
                          height: 50,
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontFamily: 'f',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),

                        ),
                      )

                    ],
                  ),

                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget date_time(){
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2)
      ),
      width: 300,
      child: TextButton(
        onPressed: ()async{
          DateTime? newDate=await showDatePicker(context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if(newDate==null)return;
          setState(() {
            date=newDate!;
          });

        },
        child: Text('Date: ${date.year} / ${date.day} / ${date.month}',
          style: TextStyle(
              fontSize: 15,
              color: Colors.black
          ),),
      ),
    );
  }
  Widget How(){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2)
          ),
          child: DropdownButton<String>(
            value: selectedItemi!.isNotEmpty?selectedItemi:null,
            items: _itemi.map((e)=>DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        child: Image.asset('assets/${e}.png'),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        e,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
                value:e)
            ).toList(),
            hint:Text(
              'How',
            ),
            isExpanded: true,
            onChanged: (value){
              setState(() {
                selectedItemi=value!;
              });
            },
            selectedItemBuilder: (BuildContext context){
              return _itemi.map((e)=>Row(
                children: [
                  Container(
                    width: 42,
                    child:Image.asset('assets/${e}.png'),
                  ),SizedBox( width: 5,),
                  Text(e),
                ],
              )).toList();
            },
          ),

        )
    );
  }
  Widget _amount(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child:TextField(

        keyboardType: TextInputType.number,
        focusNode: amount,
        controller: amount_C,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            labelText:'amount',
            errorText: _validateAmount ? 'Value Can\'t Be Empty' : null,
            labelStyle: TextStyle(fontSize: 17,),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10 ),
              borderSide: BorderSide(width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10 ),
              borderSide: BorderSide(width: 2,color:  Color.fromRGBO(222,202,255,0.98),),
            )
        ),

      ),
    );
  }
  Widget explain(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child:TextField(
        focusNode: ex,
        controller: explain_C,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            labelText:'explain',
            labelStyle: TextStyle(fontSize: 17,),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10 ),
              borderSide: BorderSide(width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10 ),
              borderSide: BorderSide(width: 2,color:  Color.fromRGBO(222,202,255,0.98),),
            )
        ),

      ),
    );
  }
  Widget name(){
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2)
          ),
          child: DropdownButton<String>(
            value: selectedItem!.isNotEmpty?selectedItem:null,
            items: _item.map((e)=>DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        child: Image.asset('assets/${e}.png'),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        e,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
                value:e)
            ).toList(),
            hint:Text(
              'Name',
            ),
            isExpanded: true,
            onChanged: (value){
              setState(() {
                selectedItem=value!;
              });
            },
            selectedItemBuilder: (BuildContext context){
              return _item.map((e)=>Row(
                children: [
                  Container(
                    width: 42,
                    child:Image.asset('assets/${e}.png'),
                  ),SizedBox( width: 5,),
                  Text(e),
                ],
              )).toList();
            },
          ),

        )
    );
  }
  Widget _backgroundcontainer(){
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
              color: Color.fromRGBO(222,202,255,0.98),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
          ),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    Text(
                      'Adding',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.attach_file_outlined,
                        color:Colors.black)
                  ],
                ),
              ),

            ],
          ),
        )
      ],
    );
  }
}
