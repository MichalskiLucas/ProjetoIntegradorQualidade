import 'package:cookmaster_front/app/data/controller/app_controller.dart';
import 'package:cookmaster_front/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          home: const AuthCheck(),
        );
      },
    );
  }
}
