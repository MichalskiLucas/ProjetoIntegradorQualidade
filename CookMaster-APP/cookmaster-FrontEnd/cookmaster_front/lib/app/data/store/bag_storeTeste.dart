// ignore_for_file: file_names

import 'package:cookmaster_front/app/data/models/bag_model.dart';
import 'package:cookmaster_front/app/data/repositories/bag_repository.dart';
import 'package:flutter/material.dart';

import '../http/exceptions.dart';

class BagStoreTeste {
  final IBagRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<int> state = ValueNotifier<int>(0);
  final ValueNotifier<BagModel> stateBag = ValueNotifier<BagModel>(BagModel());

  final ValueNotifier<String> error = ValueNotifier<String>('');

  BagStoreTeste({required this.repository});

  Future getBag(int userId) async {
    isLoading.value = true;
    try {
      final result = await repository.getBag(userId);
      stateBag.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
