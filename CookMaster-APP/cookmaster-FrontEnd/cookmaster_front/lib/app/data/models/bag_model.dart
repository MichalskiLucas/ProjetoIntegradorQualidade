import 'package:cookmaster_front/app/data/models/ingredient_model.dart';

class BagModel {
  int? id;
  int? userId;
  List<IngredientModel>? ingredients;

  BagModel({
    this.id,
    this.userId,
    this.ingredients,
  });

  factory BagModel.fromMap(Map<String, dynamic> map) {
    List<IngredientModel>? ingredients = <IngredientModel>[];
    if (map['ingredientes'] != null) {
      for (var ingredientJson in map['ingredientes']) {
        ingredients.add(IngredientModel.fromMap(ingredientJson));
      }
    }

    return BagModel(
      id: map['id'],
      userId: map['usuarioId'],
      ingredients: ingredients,
    );
  }
}
