// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class RowDynamicStar extends StatefulWidget {
  const RowDynamicStar({super.key, required this.voto});
  final int voto;

  @override
  _RowDynamicStarState createState() => _RowDynamicStarState();
}

class _RowDynamicStarState extends State<RowDynamicStar> {
  int get _voto => widget.voto;

  @override
  Widget build(BuildContext context) {
    final List<Icon> starIcons = List.generate(5, (index) {
      return Icon(
        Icons.star,
        color: index < _voto ? Colors.deepOrange : null,
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: starIcons,
    );
  }
}
