import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speetch_to_text_use/res/res.dart';
import 'package:speetch_to_text_use/screens/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: AppString.AppName,
    theme: ThemeData(primarySwatch: Colors.purple),
    home: HomeScreen(),
  );
}