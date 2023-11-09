import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/cookingRecipe_model.dart';
import 'package:cookmaster_front/app/data/models/recipeSend_model.dart';
import 'package:cookmaster_front/app/data/models/recipe_model.dart';
import 'package:cookmaster_front/common/constants.dart';

abstract class IRecipeRepository {
  Future<List<RecipeModel>> getAllRecipe();
  Future<List<RecipeModel>> getRecipeByCategory(int categoryId);
  Future<List<RecipeModel>> getAllRecipeSearch();
  Future<CookingRecipeModel> getCookingRecipe(int id);
  Future<int> postRecipe(RecipeSendModel recipeSendModel);
}

class RecipeRepository implements IRecipeRepository {
  final IHttpClient client;
  RecipeRepository({required this.client});

  @override
  Future<List<RecipeModel>> getAllRecipe() async {
    final response = await client.get(url: '${urlApi}receita/findTop');

    switch (response.statusCode) {
      case 200:
        final List<RecipeModel> recipes = [];

        try {
          const utf8decoder = Utf8Decoder();
          final body = utf8decoder.convert(response.bodyBytes);
          final parsedBody = jsonDecode(body);

          if (parsedBody is List) {
            for (var item in parsedBody) {
              final RecipeModel recipe = RecipeModel.fromMap(item);
              recipes.add(recipe);
            }
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
        return recipes;
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de receitas');
    }
  }

  @override
  Future<List<RecipeModel>> getRecipeByCategory(int categoryId) async {
    final response = await client.get(
      url: '${urlApi}receita/findByCategoria?categoriaId=$categoryId',
    );

    switch (response.statusCode) {
      case 200:
        final List<RecipeModel> recipes = [];

        try {
          const utf8decoder = Utf8Decoder();
          final body = utf8decoder.convert(response.bodyBytes);
          final parsedBody = jsonDecode(body);

          if (parsedBody is List) {
            for (var item in parsedBody) {
              final RecipeModel recipe = RecipeModel.fromMap(item);
              recipes.add(recipe);
            }
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
        return recipes;
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de receitas por categoria');
    }
  }

  @override
  Future<List<RecipeModel>> getAllRecipeSearch() async {
    final response = await client.get(
      url: '${urlApi}receita',
    );

    switch (response.statusCode) {
      case 200:
        final List<RecipeModel> recipes = [];

        try {
          const utf8decoder = Utf8Decoder();
          final body = utf8decoder.convert(response.bodyBytes);
          final parsedBody = jsonDecode(body);

          if (parsedBody is List) {
            for (var item in parsedBody) {
              final RecipeModel recipe = RecipeModel.fromMap(item);
              recipes.add(recipe);
            }
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
        return recipes;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar consulta de receitas');
    }
  }

  @override
  Future<CookingRecipeModel> getCookingRecipe(int id) async {
    final response = await client.get(
        //url: '${urlApi}receita/$id');
        url: 'https://run.mocky.io/v3/70d315db-fcce-4612-9200-56af267c0933');

    switch (response.statusCode) {
      case 200:
        try {
          final body = utf8.decode(response.bodyBytes);
          final dynamic decodedBody = jsonDecode(body);

          return CookingRecipeModel.fromMap(decodedBody);
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de receita');
    }
  }

  @override
  Future<int> postRecipe(RecipeSendModel recipeSendModel) async {
    List<Map<String, dynamic>> ingredientJsonList =
        recipeSendModel.ingredientes!.map((ingredient) {
      return ingredient.toJson();
    }).toList();

    List<Map<String, dynamic>> preparationJsonList =
        recipeSendModel.preparos!.map((preparation) {
      return preparation.toJson();
    }).toList();

    final json = jsonEncode(
      {
        'ativo': recipeSendModel.ativo,
        'descricao': recipeSendModel.descricao,
        'imagem': recipeSendModel.image,
        'voto': recipeSendModel.voto,
        'idCategoria': recipeSendModel.categoriaId,
        'idUsuario': recipeSendModel.usuarioId,
        'ingredientes': ingredientJsonList,
        'preparos': preparationJsonList
      },
    );
    final response = await client.post(
        url:
            'https://run.mocky.io/v3/ac6c6d2b-8494-4f67-bcc8-d2982eea7add', //'${urlApi}receita',
        headers: {'Content-Type': 'application/json'},
        jsonBody: json);

    switch (response.statusCode) {
      case 200:
        return 200;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar gravação de receita');
    }
  }
}
