import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/bag_model.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/common/constants.dart';

abstract class IBagRepository {
  Future<int> postBag(int userId, List<IngredientModel>? list);
  Future<int> putBag(int userId, List<IngredientModel>? list, int bagId);
  Future<BagModel> getBag(int userId);
}

class BagRepository implements IBagRepository {
  final IHttpClient client;

  BagRepository({required this.client});

  @override
  Future<int> postBag(int userId, List<IngredientModel>? list) async {
    final List<int?> ingredients = list!.map((ingredient) {
      return ingredient.id;
    }).toList();

    final json = jsonEncode(
      {
        'idUsuario': userId,
        'idIngredientes': ingredients,
      },
    );

    final response = await client.post(
        url: '${urlApi}sacola',
        headers: {'Content-Type': 'application/json'},
        jsonBody: json);

    switch (response.statusCode) {
      case 200:
        return 200;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar cadastro de sacola');
    }
  }

  @override
  Future<int> putBag(int userId, List<IngredientModel>? list, int bagId) async {
    final List<int?> ingredients = list!.map((ingredient) {
      return ingredient.id;
    }).toList();

    final json = jsonEncode(
      {
        'id': bagId,
        'idUsuario': userId,
        'idIngredientes': ingredients,
      },
    );

    final response = await client.put(
        url: '${urlApi}sacola',
        headers: {'Content-Type': 'application/json'},
        jsonBody: json);

    switch (response.statusCode) {
      case 200:
        return 200;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar atualizacao de sacola');
    }
  }

  @override
  Future<BagModel> getBag(int userId) async {
    final response = await client.get(
      url: '${urlApi}sacola/findSacolaByUsuario?usuarioId=$userId',
    );

    switch (response.statusCode) {
      case 200:
        try {
          final body = utf8.decode(response.bodyBytes);
          final dynamic decodedBody = jsonDecode(body);

          return BagModel.fromMap(decodedBody);
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar buscar sacola');
    }
  }
}
