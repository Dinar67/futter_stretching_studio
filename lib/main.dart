import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/pages/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCkQKjIzC6e1KMnHVm9Num37FxBsbuL95c',
      appId: '1:53307414469:android:c83f0eb18782a9546addac',
      messagingSenderId: '53307414469',
      projectId: 'stretching-studio-1eb66',
      storageBucket: 'stretching-studio-1eb66.appspot.com',)
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
    '/': (context) => const MainScreen(),
    },
  ));
}



