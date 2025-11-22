import 'package:flutter/material.dart';
import 'package:mostaqel1/app.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Lock to portrait mode
  ]);
  runApp(MyApp());
}
