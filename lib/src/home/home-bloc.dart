import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:meus_carros/src/model/car.dart';
import 'package:meus_carros/src/model/user.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  var _user = BehaviorSubject<User>();
  var _carros = BehaviorSubject<List<Car>>.seeded([]);
  StreamSubscription<List<Car>> _stream;

  Stream<User> get user => _user.stream;

  Stream<List<Car>> get carros => _carros.stream;

  init() {
    _user.add(converter(fb.FirebaseAuth.instance.currentUser));

    _stream = FirebaseFirestore.instance
        .collection('carros')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Car.fromMap(e.data(), e.id)).toList())
        .listen((event) {
      _carros.add(event);
    });
  }

  User converter(fb.User user) {
    return User(user.uid, user.displayName, user.email, user.photoURL);
  }

  Future<void> signOut() {
    return fb.FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    _user.close();
    _carros.close();
    _stream.cancel();
  }
}
