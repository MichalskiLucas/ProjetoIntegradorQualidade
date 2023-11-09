// ignore_for_file: unused_local_variable, unnecessary_null_comparison, file_names

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/repositories/bag_repository.dart';
import 'package:cookmaster_front/app/data/store/bag_store.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> openFilterDelegateBag(BuildContext context, IngredientStore store,
    String applyButtonText, int userId, int? bagId) async {
  List<IngredientModel> ingredientList = store.state.value;
  List<IngredientModel> selectedIngredients = [];

  bool finish = true;

  final BagStore storeBag = BagStore(
    repository: BagRepository(
      client: HttpClient(),
    ),
  );

  Future<bool> postBag(List<IngredientModel>? selectedIngredients) async {
    bool post;
    try {
      storeBag.error.value = "";
      await storeBag.postBag(userId, selectedIngredients);
      if (storeBag.error.value != "") {
        post = true;
      } else {
        post = false;
      }
    } catch (e) {
      post = false;
    }
    return post;
  }

  Future<bool> putBag(List<IngredientModel>? selectedIngredients) async {
    bool post;
    try {
      await storeBag.putBag(userId, selectedIngredients, bagId ?? 0);
      post = true;
    } catch (e) {
      post = false;
    }
    return post;
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
    onApplyButtonClick: (List<IngredientModel>? list) async {
      if (list != null && list.isNotEmpty) {
        selectedIngredients = list;
        if (bagId != null) {
          finish = await putBag(selectedIngredients);
        } else {
          finish = await postBag(selectedIngredients);
        }
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

  return finish;
}
