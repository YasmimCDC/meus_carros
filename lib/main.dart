import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meus_carros/src/app-widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}