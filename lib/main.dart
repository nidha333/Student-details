import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:practies/model/model.dart';
import 'package:practies/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
      Hive.registerAdapter(StudentModelAdapter());
    }
  } catch (e) {
    print("Error initializing Hive: $e");
  }
  bool isLoggedIn = false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: Splash(),
    );
  }
}
