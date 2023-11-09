// ignore_for_file: file_names

import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/models/preparation_model.dart';

class CookingRecipeModel {
  final int? id;
  final String? descricao;
  final String? image;
  final int? voto;
  final List<IngredientModel>? ingredientes;
  final List<PreparationModel>? preparos;

  CookingRecipeModel(
      {this.descricao,
      this.image,
      this.id,
      this.ingredientes,
      this.preparos,
      this.voto});

  factory CookingRecipeModel.fromMap(Map<String, dynamic> map) {
    List<IngredientModel>? ingredientes = <IngredientModel>[];
    if (map['ingredientes'] != null) {
      for (var ingredientJson in map['ingredientes']) {
        ingredientes.add(IngredientModel.fromMap(ingredientJson));
      }
    }

    List<PreparationModel>? preparos = <PreparationModel>[];
    if (map['preparo'] != null) {
      for (var preparoJson in map['preparo']) {
        preparos.add(PreparationModel.fromMap(preparoJson));
      }
    }

    return CookingRecipeModel(
        descricao: map['descricao'],
        image: map['image'],
        id: map['id'],
        voto: map['voto'],
        ingredientes: ingredientes,
        preparos: preparos);
  }
}
