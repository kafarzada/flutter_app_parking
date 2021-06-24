import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final pl = SpinKitPulse(
        color: Colors.black,
      size: 100,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          pl,
          Text("Подождите пожалуйста", style: TextStyle(fontSize: 18),)
        ],
      ),
    );
  }
}
