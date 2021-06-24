import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkink_app/components/title.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/screens/autoWash_screen/auto_wash_screen.dart';
import 'package:parkink_app/screens/parking_screen/parking_screen.dart';
import 'package:parkink_app/services/database.dart';
import 'package:provider/provider.dart';

class MainBody extends StatelessWidget {
  
  List<History> history;
  MainBody({this.history});

  
  
  @override
  Widget build(BuildContext context) {
    Widget _autoWish(String imgPath, String serviceTitle, void func()) {
      return GestureDetector(
        onTap: () {
          func();
        },
        child: Container(
          margin: EdgeInsets.only(right: defaultPadding / 2),
          width: 180,
          height: 180,
          decoration: BoxDecoration(
              color: Color(0xFFF5F2F2),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Transform.scale(scale: 0.5, child: Image.asset(imgPath)),
              Text(
                serviceTitle,
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
      );
    }

    Widget _parking() {
      final UserModel user = Provider.of<UserModel>(context);
      return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => Parking_screen(id: user.id)));
        },
        child: Container(
          margin: EdgeInsets.only(right: defaultPadding / 2),
          width: 180,
          height: 180,
          decoration: BoxDecoration(
              color: Color(0xFFF5F2F2),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Transform.scale(
                  scale: 0.5, child: Image.asset("assets/parking.png")),
              Text(
                "Парковка",
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
      );
    }

    Widget _services() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _autoWish("assets/wash.png", "Автомойка", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => AutoWash_Screen()));
            }),
            _parking()
          ],
        ),
      );
    }
    
    Widget _history() {
      return Expanded(
        child: ListView.builder(
          itemCount: history.length,
          itemBuilder: (_, index) => Row(
            children: [
              Text(history[index].d.toString()),
              Text(history[index].totalPrice.toString()),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title("Услуги"),
          _services(),
          // title("История Платежей"),
          // _history()
        ],
      ),
    );
  }
}
