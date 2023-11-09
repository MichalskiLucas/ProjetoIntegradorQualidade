import 'dart:convert';

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/category_model.dart';
import 'package:cookmaster_front/common/constants.dart';

import '../http/exceptions.dart';

abstract class ICategoryRepository {
  Future<List<CategoryModel>> getAllCategory();
}

class CategoryRepository implements ICategoryRepository {
  final IHttpClient client;
  CategoryRepository({required this.client});

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    final response = await client.get(
      url: '${urlApi}categoria',
    );

    switch (response.statusCode) {
      case 200:
        final List<CategoryModel> categories = [];

        try {
          final body = utf8.decode(response.bodyBytes);
          final List<dynamic> decodedBody = jsonDecode(body);

          for (var item in decodedBody) {
            final CategoryModel category = CategoryModel.fromMap(item);
            categories.add(category);
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
        return categories;
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de ingredientes');
    }
  }
}
