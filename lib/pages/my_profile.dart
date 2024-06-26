import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/database/collections/ProfileCollection';
import 'package:flutter_stretching_studio/database/firebase_auth/auth_service.dart';
import 'package:flutter_stretching_studio/database/firebase_storage/image_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:flutter_stretching_studio/global.dart' as globals;


final colRef = FirebaseFirestore.instance.collection('profiles');


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userId = FirebaseAuth.instance.currentUser!.uid.toString();
  dynamic userDoc;
  UploadTask? uploadTask;

  XFile? fileName;
  ImageStorage imageStorage = ImageStorage();
  ProfileCollection profileCollection = ProfileCollection();

  



  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  AuthService authService = AuthService();

  bool visibility = false;
  


  
  selectImageGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if(returnImage == null){
      Toast.show("Вы не выбрали изображение!");
      return;
    }

    setState(() {
      globals.selectImage = File(returnImage.path);
      uploadFile(returnImage);
      fileName = returnImage;
    });
    Toast.show("вы выбрали изображение");
  }

  ////////Метод отправки на облако//////////////

  

  getUserById() async {
    final DocumentSnapshot documentSnapshot = await colRef.doc(userId).get();
    setState(() {
      userDoc = documentSnapshot;
      
    });
  }

  void deleteImage() async {
    setState(() {
      globals.selectImage = null;
      visibility = false;
    });
  }
  

  @override
  void initState() {
    getUserById();
    super.initState();
  }

  Future uploadFile(XFile fileName) async {
    imageStorage.deleteImageStorage();
    final path = 'userLogo/${fileName.name}';
    final file = File(fileName.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final pathImageUrl = await snapshot.ref.getDownloadURL();
  
      final DocumentSnapshot documentSnapshot = await colRef.doc(userId).get();
      documentSnapshot.reference.update({'image':pathImageUrl});

      setState(() {
        uploadTask = null;
        visibility = true;
        Toast.show("Успешно!");
      });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder: (context, snapshot)
    {
      if(snapshot.hasData){
        final data = snapshot.data!;
        double progress = data.bytesTransferred / data.totalBytes;
        if(progress != 1){
        return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                color: appBarBackground,

              ),
              Center(
                child: Text(
                  '${(100 * progress).roundToDouble()}%',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )]);
        }
        else{
          return SizedBox(height: MediaQuery.of(context).size.height * 0.03,);
        }
      }
      else{
        return SizedBox(height: MediaQuery.of(context).size.height * 0.03,);
      }
    },);


  @override
  Widget build(BuildContext context) {
    surnameController.text = userDoc['surname'];
    nameController.text = userDoc['name'];
    patronymicController.text = userDoc['patronymic'];
    phoneController.text = userDoc['phone'];
    final FirebaseAuth _auth = FirebaseAuth.instance;
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.popAndPushNamed(context, '/');
          },
          icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white))
        ],
        leadingWidth: 190,
        leading: Row(
          children: 
        [
          const SizedBox(width: 10,),
          SizedBox(
             child: 
          Image.asset('assets/images/logo.png',// Установите ширину
            fit: BoxFit.cover,),
          )
        ]
      ),
        
        backgroundColor: appBarBackground,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: appBarBackground,
                    radius: 80,
                  child: ClipOval(     
                    child: userDoc['image'] == ''? 
                    (globals.selectImage == null? Image.asset('assets/images/person.png', width: 156,) 
                    : 
                    Image.file(globals.selectImage!, width: 156, fit: BoxFit.cover,)) 
                    : Image.network(userDoc['image'],
                    width: 156,
                    fit: BoxFit.cover,)
                    
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: 
                    FloatingActionButton(
                      onPressed: (){
                        selectImageGallery();
                      },
                      backgroundColor: appBarBackground,
                      child: const Text(
                        'Загрузить фото',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'bebasRegular',
                          fontSize: 18
                        ),
                      ),
                    )
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: 
                    FloatingActionButton(
                      onPressed: (){
                        imageStorage.deleteImageStorage();
                        deleteImage();
                        initState();
                      },
                      backgroundColor: appBarBackground,
                      child: const Text(
                        'Удалить фото',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'bebasRegular',
                          fontSize: 18
                        ),
                      ),
                    )
                  ),
                ],
              ),

              buildProgress(),
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
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.055,
                child: FloatingActionButton(
                  onPressed: () async {
                    if (surnameController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        patronymicController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      Toast.show("Заполните все поля!");
                    } else {
                    profileCollection.editProfile(
                      userDoc['uid'], surnameController.text, nameController.text,
                       patronymicController.text, phoneController.text
                      );
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    }
                  },
                  backgroundColor: appBarBackground,
                  child: const Text('Сохранить',
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
            ],
          ),
        ),
      ),
    );
  }
}