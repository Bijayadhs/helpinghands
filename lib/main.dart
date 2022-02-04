import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helpinghands/providers/auth_provider.dart';
import 'package:helpinghands/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ], child: const MainScreen()),
    );
  }
}
