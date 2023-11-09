// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/repositories/vote_repository.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/app/data/store/vote_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicStarRating extends StatefulWidget {
  const DynamicStarRating({
    super.key,
    required this.userStore,
    required this.idReceita,
    this.voteStore,
  });
  final UserStore userStore;
  final int idReceita;
  final VoteStore? voteStore;

  @override
  _DynamicStarRatingState createState() => _DynamicStarRatingState();
}

class _DynamicStarRatingState extends State<DynamicStarRating> {
  int rating = 0;
  UserStore get _user => widget.userStore;
  int get _idReceita => widget.idReceita;
  VoteStore? get _storeVote => widget.voteStore;

  final VoteStore store = VoteStore(
    repository: VoteRepository(
      client: HttpClient(),
    ),
  );

  loadingStars() {
    if (_storeVote?.stateGet.value.voto != null) {
      rating = _storeVote!.stateGet.value.voto ?? 0;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingStars();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> starIcons = List.generate(5, (index) {
      return IconButton(
        onPressed: () async {
          if (_user.state.value.id != 0) {
            setState(
              () {
                rating = index + 1;
              },
            );
            try {
              if (_storeVote?.stateGet.value.id != null) {
                await store.putVote(_storeVote!.stateGet.value.id, rating,
                    _user.state.value.id, _idReceita);
                if (!Get.isSnackbarOpen) {
                  Get.snackbar(
                    'Voto Atualizado',
                    'Obrigado por avaliar essa receita!',
                    snackPosition: SnackPosition.BOTTOM,
                    icon: const Icon(Icons.verified),
                    backgroundColor: Colors.green,
                  );
                }
              } else {
                await store.postVote(rating, _user.state.value.id, _idReceita);
                if (!Get.isSnackbarOpen) {
                  Get.snackbar(
                    'Voto Contabilizado',
                    'Obrigado por avaliar essa receita!',
                    snackPosition: SnackPosition.BOTTOM,
                    icon: const Icon(Icons.verified),
                    backgroundColor: Colors.green,
                  );
                }
              }
            } catch (e) {
              if (!Get.isSnackbarOpen) {
                Get.snackbar(
                  'Erro ao fazer Avaliação',
                  'Não foi possivel realizar o seu voto',
                  snackPosition: SnackPosition.BOTTOM,
                  icon: const Icon(Icons.error),
                  backgroundColor: Colors.red,
                );
              }
            }
          } else {
            if (!Get.isSnackbarOpen) {
              Get.snackbar(
                'Não realizado o voto',
                'É necessário realizar o login para votar',
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(Icons.error),
                backgroundColor: Colors.red,
              );
            }
          }
        },
        icon: Icon(
          Icons.star,
          color: index < rating ? Colors.deepOrange : null,
          size: 40,
        ),
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: starIcons,
    );
  }
}
