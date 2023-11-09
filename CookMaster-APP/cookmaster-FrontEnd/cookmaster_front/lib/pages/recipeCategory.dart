// ignore_for_file: file_names

import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/components/CardRecipe.dart';
import 'package:flutter/material.dart';

class RecipeByCategory extends StatefulWidget {
  const RecipeByCategory(
      {super.key, required this.storeRecipe, required this.storeUser});
  final RecipeStore storeRecipe;
  final UserStore storeUser;

  @override
  State<RecipeByCategory> createState() => _RecipeByCategoryState();
}

class _RecipeByCategoryState extends State<RecipeByCategory> {
  RecipeStore get _storeRecipe => widget.storeRecipe;
  UserStore get _storeUser => widget.storeUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(
        title: 'Cook Master',
        ctx: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardRecipe(
              userStore: _storeUser,
              store: _storeRecipe,
            ),
          ],
        ),
      ),
    );
  }
}
