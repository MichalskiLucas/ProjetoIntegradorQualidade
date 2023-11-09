// ignore_for_file: avoid_unnecessary_containers, unnecessary_null_comparison
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/app/data/store/vote_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/components/DynamicStarRating.dart';
import 'package:cookmaster_front/components/RowDynamicStar.dart';
import 'package:cookmaster_front/utils/decodeImageBase64.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  final RecipeStore storeCookingRecipe;
  final UserStore userStore;
  final VoteStore? voteStore;
  const RecipePage({
    super.key,
    required this.storeCookingRecipe,
    required this.userStore,
    this.voteStore,
  });

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  RecipeStore get _store => widget.storeCookingRecipe;
  UserStore get _storeUser => widget.userStore;
  VoteStore? get _storeVote => widget.voteStore;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarSimple(title: "CookMaster", ctx: context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40, left: 8.0, right: 8.0),
          child: Column(
            children: [
              _store.stateCooking.value != null
                  ? Card(
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            _store.stateCooking.value.image != null
                                ? Base64ImageConverter(
                                    imageWidth: 300,
                                    imageHeight: 200,
                                    base64Image: _store
                                        .stateCooking.value.image!
                                        .replaceAll(RegExp(r'\s+'), ''),
                                  )
                                : const Text("Imagem não disponível"),
                            const Divider(
                              color: Colors.black,
                            ),
                            Text(
                              _store.stateCooking.value.descricao!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'JacquesFrancois',
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      child: const Text(
                        "Nenhum dado disponível",
                        style: TextStyle(
                          fontFamily: 'JacquesFrancois',
                          fontSize: 20,
                        ),
                      ),
                    ),
              Container(
                height: 20,
              ),
              Card(
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/IngredientIcon.png'),
                        const Text(
                          "Ingredientes",
                          style: TextStyle(
                            fontFamily: 'JacquesFrancois',
                            fontSize: 20,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _store.stateCooking.value.ingredientes!.map(
                            (ingrediente) {
                              final descricaoComPontos =
                                  '• ${ingrediente.quantidade}${ingrediente.unMedida!.toLowerCase()} ${ingrediente.descricao};';
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  descricaoComPontos,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontFamily: 'JacquesFrancois',
                                    fontSize: 15,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
              Card(
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/PreparationIcon.png'),
                        const Text(
                          "Modo de Preparo",
                          style: TextStyle(
                            fontFamily: 'JacquesFrancois',
                            fontSize: 20,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: () {
                            int contador = 1;
                            return _store.stateCooking.value.preparos!.map(
                              (preparo) {
                                final descricaoComPontos =
                                    '$contador. ${preparo.descricao};';
                                contador++;
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    descricaoComPontos,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      fontFamily: 'JacquesFrancois',
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              },
                            ).toList();
                          }(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
              Card(
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RowDynamicStar(
                          voto: _store.stateCooking.value.voto != null
                              ? _store.stateCooking.value.voto!
                              : 0,
                        ),
                        const Text(
                          "Avaliação",
                          style: TextStyle(
                            fontFamily: 'JacquesFrancois',
                            fontSize: 20,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        DynamicStarRating(
                          idReceita: _store.stateCooking.value.id!,
                          userStore: _storeUser,
                          voteStore: _storeVote,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
