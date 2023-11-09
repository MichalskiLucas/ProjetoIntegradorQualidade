import 'package:cookmaster_front/pages/home_page.dart';
import 'package:cookmaster_front/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../atoms/chat_atom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.deepOrange),
        body: _listCookMasterLogin(context),
      ),
    );
  }
}

Widget _listCookMasterLogin(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: Image.asset('assets/images/logo.png'),
        ),
        const Text(
          "Cook Master",
          style: TextStyle(fontSize: 25, fontFamily: 'JacquesFrancois'),
        ),
        const SizedBox(height: 150),
        SizedBox(
          width: 235,
          height: 58,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Colors.deepOrange;
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: const BorderSide(color: Colors.deepOrange),
                ),
              ),
            ),
            onPressed: () async {
              chatsState.clear();
              await Get.to(
                () => const HomePage(null),
              );
            },
            child: const Text(
              'Entrar sem login',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'JacquesFrancois',
                  fontSize: 15),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 235,
          height: 58,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey.shade600;
                  }
                  return Colors.grey.shade600;
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            onPressed: () async {
              AuthService authService = AuthService();
              await authService.signInWithGoogle();
              chatsState.clear();
            },
            icon: Image.asset('assets/images/logoGoogle.png'),
            label: const Text(
              "Entrar com o google",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'JacquesFrancois',
                  color: Colors.white),
            ),
          ),
        )
      ],
    ),
  );
}
