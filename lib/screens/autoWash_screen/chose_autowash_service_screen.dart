import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkink_app/ML/ml.dart';
import 'package:parkink_app/components/button.dart';
import 'package:parkink_app/components/title.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/models/UserModel.dart';
import 'package:parkink_app/services/database.dart';
import "dart:math";
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

class ChoseAutoWashService extends StatefulWidget {
  String id;

  ChoseAutoWashService({this.id});

  @override
  _ChoseAutoWashServiceState createState() => _ChoseAutoWashServiceState();
}

class _ChoseAutoWashServiceState extends State<ChoseAutoWashService> {
  DatabaseService db = DatabaseService();
  UserModel user;

  final controller = PageController(
    initialPage: 1,
  );
  List<Service> selectedService = [];
  List<Service> services = [];
  List<Car> cars = [];
  List<Car> selectedCars = [];
  List<Setting> settings = [];
  double summ = 0;
  double s = 0;

  @override
  void initState() {
    var stream = db.getServices();
    var stream2 = db.getMaxServiceCount();
    stream2.listen((List<Setting> data) {
      setState(() {
        settings = data;
        print(settings);
      });
    });

    stream.listen((List<Service> data) {
      setState(() {
        services = data;
      });
    });

    getContext(widget.id);
  }

  void getContext(String id) {
    var stream2 = db.getCars(id);

    stream2.listen((List<Car> data) {
      if (mounted) {
        setState(() {
          cars = data;
        });
      }
    });
  }

  Widget getShortText(String text) {
    if (text.length > 30) {
      return Row(
        children: [
          Text(
            text.substring(0, 30) + "...",
            style: TextStyle(fontSize: 12),
          ),
          GestureDetector(
            child: Icon(
              Icons.read_more,
            ),
            onTap: () {
              return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(text),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      );
    } else {
      return Text(
        text,
        style: TextStyle(fontSize: 12),
      );
    }
  }

  Widget servicesList(List<Service> services) {
    return Expanded(
      child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (_, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getShortText(services[index].name),
                        Text(
                          "Цена " + services[index].price.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Switch(
                        value: services[index].isSelect,
                        onChanged: (bool val) {
                          setState(() {
                            services[index].isSelect = val;
                            //selectedService = services.where((element) => element.isSelect).toList();
                            selectedService = [];
                            selectedService
                                .addAll(services.where((e) => e.isSelect));

                            summ = 0;
                            selectedService.forEach((element) {
                              summ += element.price;
                            });
                          });
                        })
                  ])),
    );
  }

  Widget _page1() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding),
            child: title("Выберите услуги"),
          ),
          servicesList(services),
        ],
      ),
    );
  }

  Widget _page2() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding),
            child: title("Выберите Транспорт"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cars.length,
                itemBuilder: (_, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cars[index].marka),
                            Text(cars[index].model),
                          ],
                        ),
                        Switch(
                            value: cars[index].isSelect,
                            onChanged: (bool val) {
                              setState(() {
                                cars[index].isSelect = val;
                                selectedCars = cars
                                    .where((element) => element.isSelect)
                                    .toList();
                              });
                            })
                      ],
                    )),
          )
        ],
      ),
    );
  }

  Widget _page3() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding),
            child: title("Чек Лист"),
          ),
          Text(
            "Выбранные Услуги:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: selectedService.length,
                  itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(selectedService[index].name),
                      ))),
          Text("Траспорты",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
              child: ListView.builder(
                  itemCount: selectedCars.length,
                  itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(selectedCars[i].marka),
                            Text(selectedCars[i].model),
                          ],
                        ),
                      ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                settings[0].isCombo
                    ? (summ - (summ * s / 100)).toString() + " руб"
                    : summ.toString() + " руб",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Center(
              child: button(context, "Отправить", () {
            Order order = Order(
                clientId: widget.id,
                services: selectedService,
                cars: selectedCars,
                type: "Автомойка",
                totalPrice: summ);


            if (settings[0].isCombo && selectedService.length > 3) {
              print("asd");
              setState(() {
                s = ML().Rating(settings[0].maxSkidka, [
                  (order.services.length > settings[0].maxServices
                      ? settings[0].maxServices
                      : order.services.length) /
                      3,
                  3 / 3,
                  ML().getKoff(order.order_date.month)
                ]).roundToDouble();
              });

              order.totalPrice =
                  order.totalPrice - (order.totalPrice * s / 100);
            }
            db.addOrder(order).then((value) => Navigator.pop(context));
          }))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: settings.isNotEmpty
            ? PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: [_page1(), _page2(), _page3()],
              )
            : null);
  }
}
