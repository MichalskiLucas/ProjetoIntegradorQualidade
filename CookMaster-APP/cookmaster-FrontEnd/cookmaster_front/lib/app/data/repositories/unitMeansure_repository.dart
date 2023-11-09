// ignore_for_file: file_names

import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/unitMeansure_model.dart';
import 'package:cookmaster_front/common/constants.dart';

abstract class IUnitMeansureRepository {
  Future<List<UnitMeansureModel>> getUnitMeansure();
}

class UnitMeansureRepository implements IUnitMeansureRepository {
  final IHttpClient client;
  UnitMeansureRepository({required this.client});

  @override
  Future<List<UnitMeansureModel>> getUnitMeansure() async {
    final response = await client.get(
      url: '${urlApi}ingrediente/getUnitMeasure',
    );

    switch (response.statusCode) {
      case 200:
        final List<UnitMeansureModel> unitMeansures = [];

        try {
          final body = utf8.decode(response.bodyBytes);
          final List<dynamic> decodedBody = jsonDecode(body);

          for (var item in decodedBody) {
            final UnitMeansureModel unitMensure = UnitMeansureModel.fromMap(item);
            unitMeansures.add(unitMensure);
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
        return unitMeansures;
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de unidades de medida');
    }
  }
}
