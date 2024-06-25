import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/database/firebase_auth/auth_service.dart';
import 'package:flutter_stretching_studio/global.dart' as globals;


final colRef = FirebaseFirestore.instance.collection('profiles');

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();

  
}

class _NavbarState extends State<Navbar> {

  final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    dynamic userDoc;


  getUserById() async {
      if(auth.currentUser == null) {
        return;
      }
      final String userId = auth.currentUser!.uid.toString();
      final DocumentSnapshot documentSnapshot = await colRef.doc(userId).get();
      setState(() {
          userDoc = documentSnapshot;
      });
    }

  @override
  void initState() {
    getUserById();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,

        children: [
          UserAccountsDrawerHeader(
             accountName: Text(
              // "Dinar",
              auth.currentUser != null? userDoc['name'] : '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
             ),
             accountEmail: Text(auth.currentUser == null? '' : auth.currentUser!.email.toString()),
             currentAccountPicture: CircleAvatar(
              backgroundColor: appBarBackground,
              child:
              ClipOval(
              
                child: auth.currentUser != null? 
              userDoc['image'] == ''? 
                    (globals.selectImage == null? Image.asset('assets/person.png') 
                    : 
                    Image.file(globals.selectImage!, width: 200, height: 200, fit: BoxFit.cover,)) 
                    : Image.network(userDoc['image'],
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,)
                :
                Image.asset('assets/person.png')
              ),
             ),
             decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/stretchingBackground.jpg'),
                fit: BoxFit.cover
              ),
              
             ),
          ),
          auth.currentUser != null?
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Мой профиль"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            }
          )
          :
              const SizedBox(),
          ListTile(
            leading: Icon(Icons.person_2),
            title: const Text("Преподаватели"),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/list');
            },
            
          ),
          
          
          ListTile(
            
            leading: Icon(Icons.my_library_books_rounded),
            title: const Text("Мои занятия"),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/list');
            },
            
          ),
          ListTile(
            
            leading: const SizedBox(),
            title: const Text("О нас"),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/about');
            },
            
          ),
          ListTile(
            
            leading: const SizedBox(),
            title: const Text("Контакты"),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/contacts');
            },
            
          ),
          

          auth.currentUser != null?
          ListTile(
            
            leading: const Icon(Icons.logout_rounded),
            title: const Text("Выйти"),
            onTap: (){
              AuthService().logOut();
              Navigator.pushReplacementNamed(context, '/auth');
            },
            
          ) : ListTile(
            leading: const Icon(Icons.login),
            title: const Text("Войти"),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/auth');
            },
          ),
        ],
      ),
    );
  }
}