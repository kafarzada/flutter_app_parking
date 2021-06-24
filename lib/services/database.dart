import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkink_app/models/Car.dart';

class DatabaseService {
  final CollectionReference _carColllection =
      FirebaseFirestore.instance.collection(("cars"));

  final CollectionReference _serviceCollection = FirebaseFirestore.instance
      .collection("services/rggQUehfahL1LFQGS17R/autowathServices");

  final CollectionReference _orderCollection =
      FirebaseFirestore.instance.collection("orders");

  final CollectionReference _clientCollection =
      FirebaseFirestore.instance.collection("client");
  final CollectionReference _historyCollection =
      FirebaseFirestore.instance.collection("history");

  final CollectionReference _settingCollection =
      FirebaseFirestore.instance.collection("setting");

  Stream<List<Setting>> getMaxServiceCount() {
    return _settingCollection.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) => Setting.fromJson(doc.data()))
        .toList());
  }

  //обновление данных клинета
  Future<void> updateClientData(String clientId, Client client) async {
    return await _clientCollection
        .doc(clientId)
        .update(client.toMapFirstData());
  }

  //получение данных клиента
  Future<Client> getClientData(String clientId) async {
    var doc = await _clientCollection.doc(clientId).get();
    return Client.fromJson(doc.id, doc.data());
  }

  //добавление нового ТС
  Future<void> addOrUpdateCar(Car car) async {
    return await _carColllection.add(car.toMap()).then((value) => {
          _clientCollection
              .doc(car.userId)
              .update({"cars": FieldValue.increment(1)})
        });
  }

  //получение ТС
  Stream<List<Car>> getCars(String userId) {
    Query query = _carColllection.where('userID', isEqualTo: userId);

    return query.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) => Car.fromJson(doc.id, doc.data()))
        .toList());
  }

  //изменения статуса ТС
  Future<void> changeStatus(String carId, bool value) async {
    Map<String, bool> data = {"status": value};
    return await _carColllection.doc(carId).update(data);
  }

  //удаление ТС
  Future<void> deleteCar(String id) async {
    return await _carColllection.doc(id).delete();
  }

  //получение сервисов
  Stream<List<Service>> getServices() {
    return _serviceCollection.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) => Service.fromJson(doc.id, doc.data()))
        .toList());
  }

  //добавление заявки
  Future<void> addOrder(Order order) async {
    return await _orderCollection.add(order.toMap()).then((value) {
      _settingCollection.doc("FOJgu4rX7NgMXo0cJpTt").update({
        "newOrder": true
      });
    });
  }

  Future<void> deleteOrder(String id) async {
    return await _orderCollection.doc(id).delete();
  }

  //получение заявок
  Stream<List<Order>> getOrders(String userId) {
    Query query = _orderCollection.where('client', isEqualTo: userId);

    return query.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) => Order.fromJson(doc.id, doc.data()))
        .toList());
  }

  //получение истории
  Stream<List<History>> getHistory(String userId) {
    Query query = _historyCollection.where('clientId', isEqualTo: userId);

    return query.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) => History.fromJson(doc.id, doc.data()))
        .toList());
  }

  Future<void> payment(String orderId, Map<String, dynamic> data) async {
    return await _orderCollection
        .doc(orderId)
        .update(data)
        .then((d) => {_historyCollection.add(data)});
  }
}
