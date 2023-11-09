// ignore_for_file: unused_import

import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/common/constants.dart';
import 'package:filter_list/filter_list.dart';

abstract class IIngredientRepository {
  Future<List<IngredientModel>> getAllIngredients();
  Future<int> postIngredients(String description);
}

class IngredientRepository implements IIngredientRepository {
  final IHttpClient client;

  IngredientRepository({required this.client});

  @override
  Future<List<IngredientModel>> getAllIngredients() async {
    final response = await client.get(
      url: '${urlApi}ingrediente',
    );

    switch (response.statusCode) {
      case 200:
        final List<IngredientModel> ingredients = [];

        try {
          final body = utf8.decode(response.bodyBytes);
          final List<dynamic> decodedBody = jsonDecode(body);

          for (var item in decodedBody) {
            final IngredientModel ingredient = IngredientModel.fromMap(item);
            ingredients.add(ingredient);
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
        return ingredients;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar consulta de ingredientes');
    }
  }

  @override
  Future<int> postIngredients(String description) async {
    final response = await client.post(
      url: '${urlApi}ingrediente',
      headers: {'Content-Type': 'application/json'},
      jsonBody: jsonEncode(
        {
          'descricao': description,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        return 200;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar cadastro de ingrediente');
    }
  }
}
