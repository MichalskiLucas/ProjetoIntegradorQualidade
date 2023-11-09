import 'package:cookmaster_front/utils/firebase_options.dart';
import 'package:cookmaster_front/reducers/chat_reducer.dart';
import 'package:cookmaster_front/app/data/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'pages/app_widget.dart';

final reducer = ChatReducer();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  reducer;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const RxRoot(
        child: AppWidget(),
      ),
    ),
  );
}
