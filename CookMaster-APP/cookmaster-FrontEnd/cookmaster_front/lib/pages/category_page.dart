import 'package:cookmaster_front/app/data/repositories/category_repository.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/app/data/store/category_store.dart';
import 'package:cookmaster_front/pages/recipeCategory.dart';
import 'package:flutter/material.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:get/get.dart';
import '../utils/decodeImageBase64.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.storeUser});
  final UserStore storeUser;
  @override
  State<CategoryPage> createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  UserStore get _storeUser => widget.storeUser;
  final CategoryStore store = CategoryStore(
    repository: CategoryRepository(
      client: HttpClient(),
    ),
  );

  final RecipeStore storeRecipe = RecipeStore(
    repository: RecipeRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(
        ctx: context,
        title: 'Categorias',
      ),
      body: AnimatedBuilder(
        animation:
            Listenable.merge([store.isLoading, store.error, store.state]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const LinearProgressIndicator(
              color: Colors.deepOrange,
              backgroundColor: Colors.orange,
            );
          }

          if (store.error.value.isNotEmpty) {
            return Center(
              child: Text(
                store.error.value,
              ),
            );
          }

          if (store.state.value.isEmpty) {
            return const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.mood_bad,
                    size: 50,
                    color: Colors.deepOrange,
                  ),
                  Text(
                    'Não temos categorias disponiveis',
                    style: TextStyle(
                      fontFamily: "JacquesFrancois",
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];
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
      ),
    );
  }
}
