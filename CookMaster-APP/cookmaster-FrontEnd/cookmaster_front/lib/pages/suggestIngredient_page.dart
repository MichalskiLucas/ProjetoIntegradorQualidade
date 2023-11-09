import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuggestIngredientPage extends StatefulWidget {
  const SuggestIngredientPage({super.key, required this.users});
  final User? users;
  @override
  State<SuggestIngredientPage> createState() => _SuggestIngredientPageState();
}

class _SuggestIngredientPageState extends State<SuggestIngredientPage> {
  User? get _users => widget.users;

  @override
  Widget build(BuildContext context) {
    late String description = '';

    final IngredientStore storeIngredient = IngredientStore(
      repository: IngredientRepository(
        client: HttpClient(),
      ),
    );

    return Scaffold(
      appBar: AppBarSimple(
        title: 'Cook Master',
        ctx: context,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  description = value.toString();
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Ingrediente",
                  border: UnderlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await storeIngredient.postIngredient(description);
          if (storeIngredient.statePost.value == 200) {
            if (!Get.isSnackbarOpen) {
              Get.snackbar(
                'Ingrediente Sugerido!',
                'Obrigado por sugerir o ingrediente',
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(Icons.verified),
                backgroundColor: Colors.green,
              );
            }
            Get.to(() => HomePage(_users));
          } else if (storeIngredient.error.value.isNotEmpty &&
              storeIngredient.error.value != "") {
            if (!Get.isSnackbarOpen) {
              Get.snackbar(
                'Erro ao fazer sugestão',
                'Não foi possivel realizar a sua sugestão',
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(Icons.error),
                backgroundColor: Colors.red,
              );
            }
            Get.to(() => HomePage(_users));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
