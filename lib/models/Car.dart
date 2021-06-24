class Car {
  String id;
  String marka;
  String model;
  String gosNumber;
  bool status;
  int place;
  String userId;

  DateTime addedDate = DateTime.now();
  DateTime chekOutTime = DateTime.now();
  DateTime timeOfEntry = DateTime.now();
  bool isSelect = false;

  Car.fromJson(String id, Map<String, dynamic> data) {
    this.id = id;
    userId = data["userID"];
    marka = data['marka'];
    model = data['model'];
    gosNumber = data['gosNumber'];
    status = data['status'];
    place = data['place'];
  }

  Car(
      {this.marka,
      this.id = "",
      this.model,
      this.gosNumber,
      this.userId,
      this.status = false,
      this.place = 999});

  Map<String, dynamic> toMap() {
    return {
      "marka": this.marka,
      "model": this.model,
      "gosNumber": this.gosNumber,
      "status": this.status,
      "place": this.place.toInt(),
      "userID": this.userId,
      "addedDate": this.addedDate,
      "checkOutTime": this.chekOutTime,
      "timeOfEntry": this.timeOfEntry
    };
  }
}

class Client {
  String uid = "";
  String firstname;
  String lastname;
  String patronymic;
  String email;
  String phone;
  int bonus;
  DateTime registrationDate = DateTime.now();

  Client({
    this.firstname,
    this.lastname,
    this.patronymic,
    this.email,
    this.phone,
    this.bonus = 0
  });

  Client.fromJson(String id, Map<String, dynamic> data) {
    this.uid = id;
    firstname = data["firstname"];
    email = data['email'];
    lastname = data['lastname'];
    patronymic = data['patronymic'];
    phone = data['phone'];
    bonus = data["bonus"];
  }

  Map<String, dynamic> toMap() {
    return {
      "firstname": this.firstname,
      "lastname": this.lastname,
      "patronymic": this.patronymic,
      "phone": this.phone,
      "registrationDate": this.registrationDate.toLocal(),
      "bonus": this.bonus
    };
  }

  Map<String, dynamic> toMapFirstData() {
    return {
      "firstname": this.firstname,
      "lastname": this.lastname,
      "email": this.email,
      "patronymic": this.patronymic,
      "phone": this.phone,
      "registrationDate": this.registrationDate.toLocal(),
    };
  }
}

class Service {
  String name;
  double price;
  String id;
  String type = "";
  bool isSelect = false;

  Service({this.name, this.price});

  Map<String, dynamic> toMap() {
    return {"name": this.name, "price": this.price, "type": this.type};
  }

  Service.fromJson(String id, Map<String, dynamic> data) {
    this.id = id;
    this.name = data['name'];
    this.price = data['price'].toDouble();
    this.type = data["type"];
  }
}

class Order {
  String uid = "";
  String clientId = "";
  List<Car> cars;
  List<Service> services;
  String status;
  String paided;
  String type;
  double totalPrice;
  String tranzaction ="";
  DateTime order_date = DateTime.now();
  DateTime date_closed = DateTime.now();

  Order(
      {this.clientId,
      this.totalPrice,
      this.cars,
      this.services,
      this.type,
      this.paided = "Не оплачено",
      this.status = "В ожидании"});

  Map<String, dynamic> paymentToMap() {
    return {
      "tranzaction": DateTime.now().millisecondsSinceEpoch.toString(),
      "date_paided": DateTime.now(),
      "clientId": this.clientId,
      "paided": "Оплачено",
      "totalPrice": this.totalPrice,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "client": this.clientId,
      "cars": this.cars.map((c) => c.toMap()).toList(),
      "status": this.status.toString(),
      "totalPrice": this.totalPrice,
      "services": this.services.map((s) => s.toMap()).toList(),
      "order_date": this.order_date.toString(),
      "paided": this.paided,
      "type": this.type,
    };
  }

  Order.fromJson(String id, Map<String, dynamic> data) {
    this.uid = id;
    this.clientId = data["client"];
    this.services =
        (data["services"] as List).map((s) => Service.fromJson(id, s)).toList();
    this.status = data["status"].toString();
    this.totalPrice = data["totalPrice"].toDouble();
    this.cars = (data["cars"] as List).map((c) => Car.fromJson(id, c)).toList();
    this.type = data['type'];
    this.paided = data['paided'];
  }
}


class History {
  String id;
  double totalPrice;
  DateTime d;

  History({
    this.id,
    this.totalPrice,
    this.d
});

  History.fromJson(String id, Map<String, dynamic> data) {
    this.id = id;
    this.totalPrice = data['totalPrice'];
    this.d = data['date_paided'].toDate();
  }
}

class Setting {
  bool isCombo;
  double maxTotalPrice;
  int maxServices;
  bool newOrder;
  bool authoWashIsWord;
  int maxSkidka;

  Setting.fromJson( Map<String, dynamic> data) {
    this.isCombo = data["isCombo"];
    this.maxTotalPrice = data["totalPrice"];
    this.newOrder = data["newOrder"];
    this.maxServices = data["maxServices"];
    this.maxSkidka = data["maxSkidka"];
    this.authoWashIsWord = data["AutoWashIsWork"];
  }

  Map<String, dynamic> newOrderToMap() {
    return {
        "newOrder": true
    };
  }
}