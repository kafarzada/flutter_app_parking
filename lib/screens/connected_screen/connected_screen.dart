import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parkink_app/constants.dart';

class Connected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Image.asset("assets/not_connected.png",),
            Text("Проверьте подключение к \n Интернету", textAlign: TextAlign.center, style: TextStyle(color: textDangerColor, fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
