// ignore_for_file: file_names, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Base64ImageConverter extends StatelessWidget {
  final String base64Image;
  final double imageWidth;
  final double imageHeight;

  const Base64ImageConverter(
      {required this.base64Image,
      this.imageWidth = 64.0,
      this.imageHeight = 64.0});

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64Image.split(',').last);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.memory(
        bytes,
        width: imageWidth,
        height: imageHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
