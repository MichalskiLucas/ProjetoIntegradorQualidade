// ignore_for_file: file_names

import 'package:cookmaster_front/app/data/models/unitMeansure_model.dart';
import 'package:cookmaster_front/app/data/repositories/unitMeansure_repository.dart';
import 'package:flutter/material.dart';

import '../http/exceptions.dart';

class UnitMeansureStore {
  final IUnitMeansureRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<UnitMeansureModel>> state =
      ValueNotifier<List<UnitMeansureModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  UnitMeansureStore({required this.repository});

  Future getUnitMeansure() async {
    isLoading.value = true;

    try {
      final result = await repository.getUnitMeansure();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
