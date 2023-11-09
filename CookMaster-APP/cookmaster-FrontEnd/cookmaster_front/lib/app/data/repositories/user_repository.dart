import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/user_model.dart';
import 'package:cookmaster_front/common/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IUserRepository {
  Future<UserModel> postUser(User? user);
  Future<UserModel> getUser(String email);
}

class UserRepository implements IUserRepository {
  final IHttpClient client;

  UserRepository({required this.client});

  @override
  Future<UserModel> postUser(User? user) async {
    final response = await client.post(
      url: '${urlApi}usuario',
      headers: {'Content-Type': 'application/json'},
      jsonBody: jsonEncode(
        {
          'nome': '${user!.displayName}',
          'email': '${user.email}',
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        try {
          final body = jsonDecode(response.body);

          if (body is Map<String, dynamic>) {
            return UserModel.fromMap(body);
          } else {
            throw Exception('Resposta JSON inválida.');
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON: $e');
        }
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar cadastro de usuário');
    }
  }

  @override
  Future<UserModel> getUser(String email) async {
    final response = await client.get(
      url: '${urlApi}usuario/filterEmail?email=$email',
    );

    switch (response.statusCode) {
      case 200:
        try {
          final body = utf8.decode(response.bodyBytes);
          final dynamic decodedBody = jsonDecode(body);
          return UserModel.fromMap(decodedBody);
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de unidades de medida');
    }
  }
}
