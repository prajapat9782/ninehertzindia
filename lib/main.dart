import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ninehertzindia/controller/auth_controller.dart';
import 'package:ninehertzindia/controller/record_controller.dart';
import 'package:ninehertzindia/screens/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.location.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (_) => AuthController(),
        ),
        ChangeNotifierProvider<RecordController>(
          create: (_) => RecordController(),
        ),
      ],
      builder: (context, child) {
        return const MaterialApp(
          home: Login(),
        );
      },
    );
  }
}
