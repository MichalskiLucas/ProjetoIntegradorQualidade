// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:cookmaster_front/app/data/models/bag_model.dart';
import 'package:cookmaster_front/app/data/repositories/bag_repository.dart';
import 'package:cookmaster_front/app/data/repositories/category_repository.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/app/data/repositories/user_repository.dart';
import 'package:cookmaster_front/app/data/store/bag_store.dart';
import 'package:cookmaster_front/app/data/store/category_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/atoms/chat_atom.dart';
import 'package:cookmaster_front/components/CardRecipe.dart';
import 'package:cookmaster_front/components/ListTileCategory.dart';
import 'package:cookmaster_front/pages/bagView_page.dart';
import 'package:cookmaster_front/pages/category_page.dart';
import 'package:cookmaster_front/pages/astroChef_page.dart';
import 'package:cookmaster_front/pages/recipeSearch_page.dart';
import 'package:cookmaster_front/app/data/services/auth_service.dart';
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/pages/sendRecipe_page.dart';
import 'package:cookmaster_front/pages/suggestIngredient_page.dart';
import 'package:cookmaster_front/utils/openFilterDelegate.dart';
import 'package:cookmaster_front/utils/openFilterDelegateChefAstro.dart';
import 'package:cookmaster_front/widgets/auth_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/data/http/http_client.dart';
import '../app/data/repositories/ingredient_repository.dart';
import '../app/data/store/ingredient_store.dart';

class HomePage extends StatefulWidget {
  final User? users;
  const HomePage(this.users, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool validateUser = false;
  User? get _user => widget.users;
  final UserStore storeUser = UserStore(
    repository: UserRepository(
      client: HttpClient(),
    ),
  );

  final IngredientStore store = IngredientStore(
    repository: IngredientRepository(
      client: HttpClient(),
    ),
  );

  final CategoryStore storeCategory = CategoryStore(
    repository: CategoryRepository(
      client: HttpClient(),
    ),
  );

  final RecipeStore storeRecipe = RecipeStore(
    repository: RecipeRepository(
      client: HttpClient(),
    ),
  );

  final BagStore storeBag = BagStore(
    repository: BagRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      viewHomePage();
    });
    _userGet();
  }

  void viewHomePage() async {
    await storeRecipe.getRecipe();
    await storeCategory.getCategory();
  }

  _userGet() async {
    await storeUser.getUser(_user?.email!);
  }

  _startStore() {
    storeBag.stateBag.value = BagModel();
    storeBag.state.value = 0;
  }

  _userValidate() {
    if (_user != null) {
      return true;
    }
    return false;
  }

  _optionDinamyc() {
    if (_user != null) {
      return ListTile(
        leading: Image.asset('assets/images/iconExit.png'),
        title: const Text('Sair da Conta'),
        titleTextStyle: const TextStyle(
          fontFamily: 'JacquesFrancois',
          color: Colors.black,
        ),
        onTap: () async {
          await AuthService().logout();
        },
      );
    } else {
      return ListTile(
        leading: Image.asset(
          'assets/images/logoGoogleDeepOrange.png',
        ),
        title: const Text('Realizar Login'),
        titleTextStyle: const TextStyle(
          fontFamily: 'JacquesFrancois',
          color: Colors.black,
        ),
        onTap: () async {
          chatsState.clear();
          AuthService authService = AuthService();
          await authService.signInWithGoogle();
          Get.to(() => const AuthCheck());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.deepOrange),
                currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: _userValidate()
                        ? Image.network(_user?.photoURL ?? '')
                        : const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          )),
                accountName: Text(_user?.displayName ?? 'Sem Login'),
                accountEmail: Text(_user?.email ?? 'Sem Login'),
              ),
              ListTile(
                leading: Image.asset('assets/images/iconSend.png'),
                title: const Text('Enviar Receita'),
                titleTextStyle: const TextStyle(
                  fontFamily: 'JacquesFrancois',
                  color: Colors.black,
                ),
                onTap: () async {
                  _userValidate()
                      ? await Get.to(() => SendRecipeSearchPage(
                            user: _user,
                            idUser: storeUser.state.value.id,
                          ))
                      : Get.snackbar('Cook Master',
                          'Necessário realizar login para enviar uma receita.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          icon: const Icon(Icons.login));
                },
              ),
              ListTile(
                  leading: Image.asset('assets/images/iconBag.png'),
                  title: const Text('Sacola'),
                  titleTextStyle: const TextStyle(
                    fontFamily: 'JacquesFrancois',
                    color: Colors.black,
                  ),
                  onTap: () async {
                    if (_userValidate()) {
                      _startStore();
                      await storeBag.getBag(storeUser.state.value.id);
                      await Get.to(
                        () => BagViewPage(
                          user: storeUser,
                          storeUser: storeUser,
                          listIngredient: storeBag.stateBag.value.ingredients,
                          users: _user,
                          idBag: storeBag.stateBag.value.id,
                        ),
                      );
                    } else {
                      if (!Get.isSnackbarOpen) {
                        Get.snackbar('Cook Master',
                            'Necessário realizar login para usar a sacola.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            icon: const Icon(Icons.login));
                      }
                    }
                  }),
              ListTile(
                leading: Image.asset('assets/images/iconChef.png'),
                title: const Text('Chef Astro'),
                titleTextStyle: const TextStyle(
                  fontFamily: 'JacquesFrancois',
                  color: Colors.black,
                ),
                onTap: () async {
                  Get.to(() => const PageAstro());
                },
              ),
              _optionDinamyc(),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('CookMaster'),
          titleTextStyle: const TextStyle(
            fontFamily: 'JacquesFrancois',
            fontSize: 15,
          ),
          backgroundColor: Colors.deepOrange,
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.search),
              itemBuilder: (context) => [
                _buildPopUpMenuItem(
                    '  Buscar por Receitas', Icons.search, '/RecipeSearchPage'),
                _buildPopUpMenuItem('  Ingredientes Chef Astro', Icons.coffee,
                    '/ingredientPageChef'),
                _buildPopUpMenuItem('  Buscar por Ingredientes',
                    Icons.fastfood_outlined, '/ingredientPage'),
                _buildPopUpMenuItem('  Sugerir Ingredientes', Icons.edit,
                    '/suggestIngredientPage')
              ],
              onSelected: (value) async {
                if (value.toString() == '/RecipeSearchPage') {
                  await Get.to(
                    () => RecipeSearchPage(
                      storeUser: storeUser,
                    ),
                  );
                } else if (value.toString() == '/ingredientPage') {
                  await store.getAllIngredients();
                  openFilterDelegate(
                      context, store, "Filtrar", storeUser.state.value.id);
                } else if (value.toString() == '/ingredientPageChef') {
                  await store.getAllIngredients();
                  final String _messageChef = await openFilterDelegateChefAstro(
                      context, store, "Filtrar", storeUser.state.value.id);
                  if (_messageChef != "") {
                    Get.to(() => PageAstro(message: _messageChef));
                  }
                } else if (value.toString() == '/suggestIngredientPage') {
                  Get.to(
                    () => SuggestIngredientPage(
                      users: _user,
                    ),
                  );
                }
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40, left: 8.0, right: 8.0),
          child: Column(
            children: [
              CardRecipe(
                userStore: storeUser,
                store: storeRecipe,
              ),
              Container(
                color: Colors.deepOrange,
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    'Categorias',
                    style: TextStyle(
                      fontFamily: 'JacquesFrancois',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              ListTileCategory(
                store: storeCategory,
                storeUser: storeUser,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 150,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => CategoryPage(
                        storeUser: storeUser,
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(255, 87, 34, 1)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  child: const Text("Ver Mais..."),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

PopupMenuItem _buildPopUpMenuItem(String title, IconData icon, String value) {
  return PopupMenuItem(
    value: value,
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'JacquesFrancois',
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
