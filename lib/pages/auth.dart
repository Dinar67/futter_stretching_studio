import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/database/firebase_auth/auth_service.dart';
import 'package:toast/toast.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool visibility = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AuthService authService = AuthService();


  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: appBarBackground,
        actions: [
          IconButton(onPressed: (){
            Navigator.popAndPushNamed(context, '/');
          },
          icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white))
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        leadingWidth: 190,
        leading: Row(
          children: 
        [
          const SizedBox(width: 10,),
          SizedBox(
             child: 
          Image.asset('assets/images/logo.png',// Установите высоту
            fit: BoxFit.cover,),
          )
        ]
      ),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Добро пожаловать!", style: TextStyle(
              color: appBarBackground,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: 'bebasRegular'
            ),),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: emailController,
                style: const TextStyle(color: appBarBackground),
                cursorColor: appBarBackground,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: appBarBackground,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: appBarBackground),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: appBarBackground),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    color: appBarBackground,
                  ),
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: appBarBackground),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: passController,
                obscureText: !visibility,
                style: const TextStyle(color: appBarBackground),
                cursorColor: appBarBackground,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    icon: !visibility
                        ? const Icon(
                            Icons.visibility,
                            color: appBarBackground,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: appBarBackground,
                          ),
                  ),
                  prefixIcon: const Icon(
                    Icons.password,
                    color: appBarBackground,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: appBarBackground),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: appBarBackground),
                  ),
                  labelText: 'Пароль',
                  labelStyle: const TextStyle(
                    color: appBarBackground,
                  ),
                  hintText: 'Пароль',
                  hintStyle: const TextStyle(color: appBarBackground),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              child: FloatingActionButton(
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passController.text.isEmpty) {
                    Toast.show("Заполните все поля");
                  } else {
                    var user = await authService.signIn(
                        emailController.text, passController.text);
                    if (user == null) {
                      Toast.show("Неправильный Email/Пароль!");
                    } else {
                      // ignore: use_build_context_synchronously
                      Navigator.popAndPushNamed(context, '/');
                      Toast.show("Вы вошли!");
                    }
                  }
                },
                backgroundColor: appBarBackground,
                child: const Text('Войти', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'bebasRegular',
                  fontSize: 18
                ),),
                  
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            InkWell(
              child: const Text(
                'Нет аккаунта? Зарегистрируйтесь!',
                style: TextStyle(color: appBarBackground,
                fontFamily: 'bebasRegular',
                fontSize: 16),
              ),
              onTap: () => Navigator.popAndPushNamed(context, '/reg'),
            ),
          ],
        ),
      ),
    );
  }
}