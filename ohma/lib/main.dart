import 'package:demo_project/components/repository/authentication_repository/authentication/authentication_repository.dart';
import 'package:demo_project/routs.dart';
import 'package:demo_project/screens/splash/splash_screen.dart';
import 'package:demo_project/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

// await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (value) => Get.put(AuthenticationRepository()),
  );
  // FirebaseAppCheck.instance.activate();
    //Get.put(FirebaseStorageService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
Widget build(BuildContext context) {
  return Container(
    child: Builder(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          home: const SplashScreen(), // Set SplashScreen as the home
          initialRoute: SplashScreen.routeName,
          routes: routes,
        );
      }
    ),
  );
}

}
