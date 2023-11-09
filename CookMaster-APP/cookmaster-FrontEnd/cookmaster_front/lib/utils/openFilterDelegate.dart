// ignore_for_file: unused_local_variable, unnecessary_null_comparison, file_names

import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void openFilterDelegate(BuildContext context, IngredientStore store,
    String applyButtonText, int userId) async {
  List<IngredientModel> ingredientList = store.state.value;
  List<IngredientModel> selectedIngredients = [];

  await FilterListDelegate.show(
    context: context,
    applyButtonText: applyButtonText,
    list: ingredientList,
    searchFieldHint: 'Consultar Ingrediente',
    searchFieldStyle: const TextStyle(
      fontFamily: 'JacquesFrancois',
    ),
    selectedListData: selectedIngredients,
    tileLabel: (IngredientModel? item) {
      if (item == null) return '';
      return item.descricao;
    },
    onItemSearch: (IngredientModel item, String query) {
      return item.descricao!.toLowerCase().contains(query.toLowerCase());
    },
    onApplyButtonClick: (List<IngredientModel>? list) {
      if (list != null && list.isNotEmpty) {
        selectedIngredients = list;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            'Cook Master',
            'Não foi selecionado nenhum ingrediente!',
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.warning),
            backgroundColor: Colors.yellow,
          );
        }
      }
    },
  );
}
