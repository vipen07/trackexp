import 'package:flutter/material.dart';
import 'package:trackexp/Model/seeall.dart';
class See_All extends StatefulWidget {
  const See_All({Key? key}) : super(key: key);

  @override
  State<See_All> createState() => _See_AllState();
}

class _See_AllState extends State<See_All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SeeAll(),
          ],
        ),
      ),
    );
  }
}
