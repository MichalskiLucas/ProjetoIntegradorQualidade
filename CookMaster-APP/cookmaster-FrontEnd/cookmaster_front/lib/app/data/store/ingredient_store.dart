import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:flutter/material.dart';

class IngredientStore {
  final IIngredientRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<IngredientModel>> state =
      ValueNotifier<List<IngredientModel>>([]);
  final ValueNotifier<int> statePost = ValueNotifier<int>(0);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  IngredientStore({required this.repository});

  Future getAllIngredients() async {
    isLoading.value = true;

    try {
      final result = await repository.getAllIngredients();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postIngredient(String description) async {
    isLoading.value = true;

    try {
      final result = await repository.postIngredients(description);
      statePost.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
