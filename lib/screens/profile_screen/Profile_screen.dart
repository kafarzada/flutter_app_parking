import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/screens/profile_screen/EditProfile.dart';
import 'package:parkink_app/services/database.dart';

class ProfileScreen extends StatefulWidget {
  String id;
  ProfileScreen({
    this.id
});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Client client;

  loadData()async {
    DatabaseService db = DatabaseService();

    await db.getClientData(widget.id).then((value) {
        setState(() {
          client = value;
        });
      });

  }
  





  @override
  Widget build(BuildContext context) {
    setState(() {
      loadData();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Профиль",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all( defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                child: SvgPicture.asset("assets/ava.svg"),
                backgroundColor: Colors.white,
                radius: 50,
              ),
            ),
              Container(
                child: client != null ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Имя:  " + client.firstname,style: TextStyle(fontSize: 23),),
                    Text("Фамилия:  "+ client.lastname,style: TextStyle(fontSize: 23)),
                    Text("email: " + client.patronymic,style: TextStyle(fontSize: 23)),
                    Text("Номер телефона " + client.phone,style: TextStyle(fontSize: 23)),
                    Text("Бонус: " + client.bonus.toString(),style: TextStyle(fontSize: 23)),
                  ],
                ): null
              ),
            Spacer(flex: 1,),
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => EditProfile() ));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,

                  child: Text(
                    "Редактировать",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: buttonColor),
                  ),
                ),
                textColor: Colors.white,
                splashColor: Colors.white24,
                padding: EdgeInsets.symmetric(vertical: 16),

              ),
            )
          ],
        ),
      ),
    );
  }
}
