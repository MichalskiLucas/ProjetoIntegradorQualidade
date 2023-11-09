// ignore_for_file: non_constant_identifier_names, unused_import, file_names

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/components/CardRecipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeSearchPage extends StatefulWidget {
  const RecipeSearchPage({super.key, required this.storeUser});
  final UserStore storeUser;

  @override
  State<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

final RecipeStore storeRecipe = RecipeStore(
  repository: RecipeRepository(
    client: HttpClient(),
  ),
);

class _RecipeSearchPageState extends State<RecipeSearchPage> {
  @override
  void initState() {
    super.initState();
    getRecipe();
  }

  void getRecipe() async {
    await storeRecipe.getRecipeSearch();
  }

  UserStore get _storeUser => widget.storeUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarSearch(
          ctx: context,
          labelText: 'Buscar Receita',
          storeRecipe: storeRecipe,
        ),
        body: _CookMasterSearchRecipe(context, _storeUser),
      ),
    );
  }
}

Widget _CookMasterSearchRecipe(BuildContext context, UserStore storeUser) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          CardRecipe(
            userStore: storeUser,
            store: storeRecipe,
          ),
        ],
      ),
    ),
  );
}
