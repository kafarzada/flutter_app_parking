import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/screens/car_screen/Add_car.dart';
import 'package:parkink_app/screens/home/component/ProfileBody.dart';
import 'package:parkink_app/screens/home/component/mainBody.dart';
import 'package:parkink_app/screens/home/component/Car_List.dart';
import 'package:parkink_app/services/database.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;

  const HomeScreen({Key key, this.user}): super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel user;
  int _selectedIndex = 1;

  List<History> history = [];
  DatabaseService db = DatabaseService();





  Widget getPage(String id, int index) {
    var stream = db.getHistory(id);
    // stream.listen((List<History> data) {
    //
    //     setState(() {
    //       history = data;
    //       print(history);
    //     });
    //
    // });
    final section_srceens = [
      Car_List(id: id),
      MainBody(history: history),
      ProfileBody()
    ];
    return section_srceens[index];
  }


  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context);
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text("Parking", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: getPage(user.id, _selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => AddCar()));
        },
        backgroundColor: buttonColor,
        child: Icon(Icons.add, color: Colors.white,),
      ),
      bottomNavigationBar: CurvedNavigationBar(color: buttomNavColor,
        items: <Widget>[
          Icon(Icons.directions_car_outlined),
          Icon(Icons.home_outlined),
          Icon(Icons.person_outline)
        ],
        index: 1,
        height: 50,
        backgroundColor: backGroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 250),
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
