import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NUMBER = 'number';
  static const ID = 'id';
  static const STATUS = 'status';

  late String _number;
  late String _id;
  late String _status;

  String get number => _number;
  String get id => _id;
  String get status => _status;

  UserModel.fromSnapShot(DocumentSnapshot snapshot) {
    if (snapshot.data() != null) {
      _number = snapshot.get([NUMBER]);
      _id = snapshot.get([ID]);
      _status = snapshot.get([STATUS]);
    }
  }
}
