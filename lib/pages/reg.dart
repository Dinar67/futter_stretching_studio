import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/database/collections/ProfileCollection';
import 'package:flutter_stretching_studio/database/firebase_auth/auth_service.dart';
import 'package:toast/toast.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

 


  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AuthService authService = AuthService();
  ProfileCollection profileCollection = ProfileCollection();
  bool visibility = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: appBarBackground,
        leadingWidth: 190,
        leading: Row(
          children: 
        [
          const SizedBox(width: 10),
          SizedBox(
             child: 
          Image.asset('assets/images/logo.png',
            fit: BoxFit.cover,),
          )
        ]
      ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              const Text("Регистрация",
              style: TextStyle(
                color: appBarBackground,
                fontWeight: FontWeight.bold,
                fontSize: 35,
                fontFamily: 'bebasRegular'
              ),),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: surnameController,
                  style: const TextStyle(color: appBarBackground),
                  cursorColor: appBarBackground,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.face,
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
                    labelText: 'Фамилия',
                    labelStyle: const TextStyle(
                      color: appBarBackground,
                    ),
                    hintText: 'Фамилия',
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
                  controller: nameController,
                  style: const TextStyle(color: appBarBackground),
                  cursorColor: appBarBackground,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.face,
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
                    labelText: 'Имя',
                    labelStyle: const TextStyle(
                      color: appBarBackground,
                    ),
                    hintText: 'Имя',
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
                  controller: patronymicController,
                  style: const TextStyle(color: appBarBackground),
                  cursorColor: appBarBackground,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.face,
                      color: appBarBackground,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: appBarBackground)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: appBarBackground),
                    ),
                    labelText: 'Отчество',
                    labelStyle: const TextStyle(
                      color: appBarBackground,
                    ),
                    hintText: 'Отчество',
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
                  controller: phoneController,
                  style: const TextStyle(color: appBarBackground),
                  cursorColor: appBarBackground,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone,
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
                    labelText: 'Телефон',
                    labelStyle: const TextStyle(
                      color: appBarBackground,
                    ),
                    hintText: 'Телефон',
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
                    labelText: 'Почта',
                    labelStyle: const TextStyle(
                      color: appBarBackground,
                    ),
                    hintText: 'Почта',
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
                    if (surnameController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        patronymicController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passController.text.isEmpty) {
                      Toast.show("Заполните все поля!");
                    } else {
                      var user = await authService.signUp(
                          emailController.text, passController.text);
                      if (user == null) {
                        Toast.show("Проверьте правильность данных!");
                      } else {
                        await profileCollection.addProfile(
                          user.id!,
                          surnameController.text,
                          nameController.text,
                          patronymicController.text,
                          phoneController.text,
                          emailController.text,
                          passController.text,
                          ''
                        );
                        Toast.show("Вы успешно зарегистрировались!");
                        Navigator.popAndPushNamed(context, '/');
                      }
                    }
                  },
                  backgroundColor: appBarBackground,
                  child: const Text('Зарегистрироваться',
                  style: TextStyle(
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
                  'Есть аккаунт? Войти',
                  style: TextStyle(color: appBarBackground,
                  fontFamily: 'bebasRegular',
                  fontSize: 16
                  ),
                ),
                onTap: () => Navigator.popAndPushNamed(context, '/auth'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}