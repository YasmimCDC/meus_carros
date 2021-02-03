import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meus_carros/src/home/home-widget.dart';
import 'package:meus_carros/src/services/authentication/authentication.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc extends BlocBase {
  final Authentication _authentication = new Authentication();
  var _loadingController = BehaviorSubject.seeded(false);


  Stream<bool> get outLoading => _loadingController.stream;

  final BuildContext context;

  LoginBloc(this.context);

  onClickLogin() async {
    _loadingController.add(true);
    await _authentication.siginWithGoogle();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeWidget()));
    _loadingController.add(false);
  }

  @override
  void dispose() {
    _loadingController.close();
  }
}
