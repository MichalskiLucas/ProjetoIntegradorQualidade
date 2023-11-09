// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/vote_model.dart';
import 'package:cookmaster_front/common/constants.dart';

abstract class IVoteRepository {
  Future<int> postVote(int voto, int idUsuario, int idreceita);
  Future<int> putVote(int? id, int voto, int idUsuario, int idreceita);
  Future<VoteModel> getVoteByUser(int userId, int recipeId);
}

class VoteRepository implements IVoteRepository {
  final IHttpClient client;

  VoteRepository({required this.client});

  @override
  Future<int> postVote(int voto, int idUsuario, int idReceita) async {
    final response = await client.post(
      url: '${urlApi}voto',
      headers: {'Content-Type': 'application/json'},
      jsonBody: jsonEncode(
        {
          'voto': voto,
          'idUsuario': idUsuario,
          'idReceita': idReceita,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        return 200;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar cadastro de voto');
    }
  }

  @override
  Future<int> putVote(int? id, int voto, int idUsuario, int idReceita) async {
    final response = await client.put(
      url: '${urlApi}voto',
      headers: {
        'Content-Type': 'application/json',
      },
      jsonBody: jsonEncode(
        {
          'id': id,
          'voto': voto,
          'idUsuario': idUsuario,
          'idReceita': idReceita,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        return 200;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar atualizacao de voto');
    }
  }

  @override
  Future<VoteModel> getVoteByUser(int userId, int recipeId) async {
    final response = await client.get(
      url:
          '${urlApi}/voto/findVotoByUsuario?usuarioId=$userId&receitaId=$recipeId',
    );

    switch (response.statusCode) {
      case 200:
        try {
          final body = utf8.decode(response.bodyBytes);
          final dynamic decodedBody = jsonDecode(body);

          return VoteModel.fromMap(decodedBody);
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de votos');
    }
  }
}
