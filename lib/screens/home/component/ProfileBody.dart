import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/screens/order_screen/Order_screen.dart';
import 'package:parkink_app/screens/profile_screen/Profile_screen.dart';
import 'package:parkink_app/services/auth.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: FlatButton(
                onPressed: ()  { Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProfileScreen(id: user.id) )); } ,
                child: Text("Мои Данные"),
              ),
            ),

            SizedBox(
              width: double.infinity,

              child: FlatButton(
                onPressed: ()  { Navigator.push(context, MaterialPageRoute(builder: (ctx) =>OrderScreen(userId: user.id,) )); } ,
                child: Text("Мои Заявки"),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: FlatButton(
                onPressed: () async { await AuthService().logOut();} ,
                child: Text("Выход"),
              ),
            ),

          ],
        )
    );
  }
}
