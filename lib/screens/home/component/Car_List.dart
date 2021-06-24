import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:parkink_app/components/title.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/services/database.dart';
import 'package:provider/provider.dart';

class Car_List extends StatefulWidget {
  String id;

  Car_List({this.id});

  @override
  _Car_ListState createState() => _Car_ListState();
}

class _Car_ListState extends State<Car_List> {
  UserModel user;
  DatabaseService db = DatabaseService();
  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
    loadCars();
  }

  Widget CarDetail(Car car) {
    return Container(
      margin: EdgeInsets.only(bottom: defaultPadding / 2),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding / 2, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        color: Color(0xFFF5F2F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                car.marka,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              Text(
                car.model,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              Text(
                car.gosNumber.toString(),
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.8,
            child: LiteRollingSwitch(
              value: car.status,
              textOn: 'На Месте',
              textOff: 'Выехал',
              colorOn: Colors.greenAccent[700],
              colorOff: Colors.redAccent[700],
              iconOn: Icons.done,
              iconOff: Icons.remove_circle_outline,
              textSize: 15,
              onChanged: (bool state) {
                db.changeStatus(car.id, state);
                print(car.status);
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                db.deleteCar(car.id);
              })
        ],
      ),
    );
  }

  Widget _car_list() {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (_, index) => CarDetail(cars[index]),
    );
  }

  loadCars() async {
    var stream = db.getCars(widget.id);

    stream.listen((List<Car> data) {
      if (mounted)
        setState(() {
          cars = data;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context);
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding),
            child: title("Мои Транспорты"),
          ),
          Expanded(
            child: _car_list(),
          ),
        ],
      ),
    ));
  }
}
