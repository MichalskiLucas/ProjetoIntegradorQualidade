// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ButtonFinishBag extends StatelessWidget {
  const ButtonFinishBag({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 140,
          height: 40,
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
            onPressed: () {},
            child: const Text('Finalizar'),
          ),
        ),
      ),
    );
  }
}
