import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parkink_app/components/button.dart';
import 'package:parkink_app/components/title.dart';
import 'package:parkink_app/constants.dart';
import 'package:parkink_app/models/Car.dart';
import 'package:parkink_app/services/database.dart';

class Parking_screen extends StatefulWidget {
  String id;

  Parking_screen({this.id});

  @override
  _Parking_screenState createState() => _Parking_screenState();
}

class _Parking_screenState extends State<Parking_screen> {
  final controller = PageController(
    initialPage: 1,
  );
  DatabaseService db = DatabaseService();
  List<Car> cars = [];
  List<Car> selectedCars = [];


  String serviceType = "Дней";
  double days = 1;
  double month = 1;
  double price_month = 5000;
  double price_day = 170;
  double summ = 170;
  double totalSumm = 170;
  Service service = Service(name: "Дней", price: 0.0);
  List<Service> selectedSevices = [];

  @override
  void initState() {
    super.initState();
    selectedSevices.add(service);
    loadCars(widget.id);
    print(cars.length);
  }

  void loadCars(String id) async {
    var stream2 = await db.getCars(id);

    stream2.listen((List<Car> data) {
        if(mounted) {
          setState(() {
            cars = data;
          });
        }
    });
  }

  Widget _page1() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          title("Тип Услуги:"),
          Row(
            children: [
              Radio(
                  value: "Дней",
                  groupValue: serviceType,
                  onChanged: (String v) {
                    setState(() {
                      serviceType = v;
                      setState(() {
                        selectedSevices[0].name = serviceType;
                        selectedSevices[0].price = price_day;
                        summ = price_day;
                        month = 1;
                      });
                    });
                  }),
              Text("Определенное Количество дней")
            ],
          ),
          Row(
            children: [
              Radio(
                  value: "Месяцев",
                  groupValue: serviceType,
                  onChanged: (String v) {
                    setState(() {
                      serviceType = v;
                      setState(() {
                        selectedSevices[0].name = serviceType;
                        selectedSevices[0].price = price_month;
                        summ = price_month;
                        days = 1;
                      });
                    });
                  }),
              Text("За Месяц")
            ],
          ),
          Spacer(
            flex: 1,
          ),
          serviceType == "Дней" ? _daysWidget() : _monthWidget(),
          Spacer(
            flex: 2,
          )
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
                itemBuilder: (_, index) =>
                    Row(
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
                                 totalSumm = summ * selectedCars.length;
                                 print(totalSumm);
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
            child:ListView.builder(
                itemCount: selectedSevices.length,
                itemBuilder: (_, i) =>
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(selectedSevices[i].name),
                        ],
                      ),
                    )) ,
          ),

          Text("Траспорты",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
              child: ListView.builder(
                  itemCount: selectedCars.length,
                  itemBuilder: (_, i) =>
                      Padding(
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
                totalSumm.toString() + " руб",
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
                    services: selectedSevices,
                    cars: selectedCars,
                    type: "Автостоянка",
                    totalPrice: totalSumm);
                db.addOrder(order).then((value) => Navigator.pop(context));
              }))
        ],
      ),
    );
  }

  Widget _daysWidget() {
    return Column(
      children: [
        Text(
          "Количество дней (" + summ.toString() + "руб)",
          style: TextStyle(fontSize: 18),
        ),
        Slider(
          value: days,
          onChanged: (double v) {
            setState(() {
              days = v.ceilToDouble();
              setState(() {
                  summ = 1;
                  summ += days * price_day;
              });
            });
          },
          min: 1,
          max: 15,
          divisions: 15,
          label: days.ceil().toString(),
          activeColor: primaryColor,
        )
      ],
    );
  }

  Widget _monthWidget() {
    return Column(
      children: [
        Text(
          "Количество месяцев (" + summ.toString() + "руб)",
          style: TextStyle(fontSize: 18),
        ),
        Slider(
          value: month,
          onChanged: (double v) {
            setState(() {
              month = v.ceilToDouble();
              setState(() {
                summ = 0;
                summ += month * price_month;
              });
            });
          },
          min: 1,
          max: 12,
          divisions: 12,
          label: month.ceil().toString(),
          activeColor: primaryColor,
        )
      ],
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
        body: PageView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          children: [_page1(), _page2(), _page3()],
        ));
  }
}
