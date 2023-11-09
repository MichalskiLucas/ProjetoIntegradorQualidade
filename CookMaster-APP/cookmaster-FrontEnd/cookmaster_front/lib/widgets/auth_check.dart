import 'package:cookmaster_front/pages/home_page.dart';
import 'package:cookmaster_front/pages/login_page.dart';
import 'package:cookmaster_front/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoading) {
      return loading();
    } else if (auth.users == null) {
      return const LoginPage();
    } else {
      return HomePage(auth.users);
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: LinearProgressIndicator(
          color: Colors.deepOrange,
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }
}
