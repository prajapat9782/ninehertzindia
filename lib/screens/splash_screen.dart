import 'package:flutter/material.dart';
import 'package:ninehertzindia/controller/auth_controller.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _myFunction(context),
          child: const Text("Login"),
        ),
      ),
    );
  }

  _myFunction(context) {
    Provider.of<AuthController>(context, listen: false).signIn(context);
  }
}
