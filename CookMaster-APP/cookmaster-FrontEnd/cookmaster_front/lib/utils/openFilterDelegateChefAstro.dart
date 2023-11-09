// ignore_for_file: unused_local_variable, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, file_names

import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<String> openFilterDelegateChefAstro(BuildContext context,
    IngredientStore store, String applyButtonText, int userId) async {
  List<IngredientModel> ingredientList = store.state.value;
  List<IngredientModel> selectedIngredients = [];

  String _messageIngredient = "";

  String _message(List<IngredientModel> list) {
    var ingredienteMessage =
        "Eu gostaria de 1 opção de receita somente com os seguintes ingredientes: \n";
    if (list != null) {
      ingredienteMessage = ingredienteMessage +
          list.map((ingredient) => ingredient.descricao).join(', \n');

      return ingredienteMessage;
    }
    return "";
  }

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
        _messageIngredient = _message(selectedIngredients);
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            'Chef Astro',
            'Não foi selecionado nenhum ingrediente!',
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.warning),
            backgroundColor: Colors.yellow,
          );
        }
      }
    },
  );

  return _messageIngredient;
}
