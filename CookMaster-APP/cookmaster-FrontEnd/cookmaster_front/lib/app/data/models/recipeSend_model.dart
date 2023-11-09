// ignore_for_file: file_names

import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/models/preparation_model.dart';

class RecipeSendModel {
  final bool? ativo;
  final String? descricao;
  final String? image;
  final int? voto;
  final int? categoriaId;
  final int? usuarioId;
  final List<IngredientModel>? ingredientes;
  final List<PreparationModel>? preparos;

  RecipeSendModel({
    required this.ativo,
    required this.descricao,
    required this.image,
    required this.voto,
    required this.categoriaId,
    required this.usuarioId,
    required this.ingredientes,
    required this.preparos,
  });

  factory RecipeSendModel.fromMap(Map<String, dynamic> map) {
    List<PreparationModel>? preparos = <PreparationModel>[];
    if (map['preparo'] != null) {
      for (var preparoJson in map['preparo']) {
        preparos.add(PreparationModel.fromMap(preparoJson));
      }
    }

    List<IngredientModel>? ingredientes = <IngredientModel>[];
    if (map['ingredientes'] != null) {
      for (var ingredientsJson in map['ingredientes']) {
        ingredientes.add(IngredientModel.fromMap(ingredientsJson));
      }
    }

    return RecipeSendModel(
        ativo: map['ativo'],
        descricao: map['descricao'],
        image: map['image'],
        voto: map['voto'],
        categoriaId: map['categoriaId'],
        usuarioId: map['usuarioId'],
        ingredientes: ingredientes,
        preparos: preparos);
  }
}
