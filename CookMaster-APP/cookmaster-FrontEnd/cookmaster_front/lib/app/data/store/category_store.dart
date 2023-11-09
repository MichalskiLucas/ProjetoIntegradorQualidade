import 'package:cookmaster_front/app/data/models/category_model.dart';
import 'package:cookmaster_front/app/data/repositories/category_repository.dart';
import 'package:flutter/material.dart';

import '../http/exceptions.dart';

class CategoryStore {
  final ICategoryRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<CategoryModel>> state =
      ValueNotifier<List<CategoryModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  CategoryStore({required this.repository});

  Future getCategory() async {
    isLoading.value = true;
    try {
      final result = await repository.getAllCategory();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
