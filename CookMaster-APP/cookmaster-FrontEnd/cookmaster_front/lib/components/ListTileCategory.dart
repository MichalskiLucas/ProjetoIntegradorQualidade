// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/app/data/store/category_store.dart';
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/pages/recipeCategory.dart';
import 'package:cookmaster_front/utils/decodeImageBase64.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTileCategory extends StatefulWidget {
  const ListTileCategory(
      {Key? key, required this.store, required this.storeUser})
      : super(key: key);
  final CategoryStore store;
  final UserStore storeUser;

  @override
  _ListTileCategoryState createState() => _ListTileCategoryState();
}

class _ListTileCategoryState extends State<ListTileCategory> {
  CategoryStore get _store => widget.store;
  UserStore get _storeUser => widget.storeUser;

  final RecipeStore storeRecipe = RecipeStore(
    repository: RecipeRepository(
      client: HttpClient(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
        [
          _store.isLoading,
          _store.error,
          _store.state,
        ],
      ),
      builder: (context, child) {
        if (_store.isLoading.value) {
          return const Center(
            child: LinearProgressIndicator(
              color: Colors.deepOrange,
              backgroundColor: Colors.orange,
            ),
          );
        }

        if (_store.error.value.isNotEmpty) {
          return const Center(
            child: Text(
              'Categorias indísponiveis!',
              style: TextStyle(
                fontFamily: 'JacquesFrancois',
                fontSize: 15,
              ),
            ),
          );
        }

        if (_store.state.value.isEmpty) {
          return const Center(
            child: Text('lista vazia'),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount:
                _store.state.value.length >= 5 ? 5 : _store.state.value.length,
            itemBuilder: (_, index) {
              final item = _store.state.value[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () async {
                    await storeRecipe.getRecipeByCategory(item.id);
                    Get.to(
                      () => RecipeByCategory(
                        storeRecipe: storeRecipe,
                        storeUser: _storeUser,
                      ),
                    );
                  },
                  leading: Base64ImageConverter(
                    base64Image: item.image.replaceAll(RegExp(r'\s+'), ''),
                  ),
                  trailing:
                      const Icon(Icons.arrow_forward, color: Colors.black),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    item.descricao,
                    style: const TextStyle(
                      fontFamily: 'JacquesFrancois',
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
