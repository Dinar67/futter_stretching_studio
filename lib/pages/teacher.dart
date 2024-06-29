import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/database/collections/ProfileCollection';
import 'package:flutter_stretching_studio/global.dart' as globals;
import 'package:flutter_stretching_studio/widgets/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

final ProfileCollection profile = ProfileCollection();
final FirebaseFirestore db = FirebaseFirestore.instance;
UploadTask? uploadTask;

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: appBar(context),
      body: StreamBuilder(
        stream: db.collection('teachers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          }

          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, int index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      20,
                      MediaQuery.of(context).size.width * 0.05,
                      10),
                  color: appBarBackground,
                  key: Key(snapshot.data!.docs[index].id),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: snapshot.data!.docs[index].get('image') == ''
                                ? Image.asset('assets/images/person.png')
                                : ClipOval(
                                    child: Image.network(
                                      snapshot.data!.docs[index].get('image'),
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.59,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index].get('surname'),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'bebasRegular',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index].get('name'),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'bebasRegular',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: 130,
                                      height: 25,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          globals.selectedTeacher =
                                              snapshot.data!.docs[index];
                                          Navigator.popAndPushNamed(
                                              context, '/');
                                        },
                                        backgroundColor: Colors.white,
                                        child: const Text(
                                          'Посмотреть занятия',
                                          style: TextStyle(
                                              color: appBarBackground,
                                              fontFamily: 'bebasRegular',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          globals.typeAction = 'edit';
                                          globals.selectedTeacher =
                                              snapshot.data!.docs[index];
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return teacherAlert(context);
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await db
                                              .collection('teachers')
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                          Toast.show('Удалено!');
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          globals.typeAction = 'add';
          showDialog(
              context: context,
              builder: (context) {
                return teacherAlert(context);
              });
        },
        backgroundColor: appBarBackground,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;
  XFile? fileName;

  Widget teacherAlert(BuildContext context) {
    ToastContext().init(context);

    final TextEditingController nameController = TextEditingController();
    final TextEditingController surnameController = TextEditingController();
    if (globals.typeAction == 'edit') {
      nameController.text = globals.selectedTeacher!.get('name');
      surnameController.text = globals.selectedTeacher!.get('surname');
    }

    Future uploadFile(XFile fileName) async {
      if (globals.selectedTeacher != null &&
          globals.selectedTeacher!.get('image') != '') {
        await FirebaseStorage.instance
            .refFromURL(globals.selectedTeacher!.get('image'))
            .delete();
        await globals.selectedTeacher!.reference.update({'image': ''});
      }
      final path =
          'teachers/${globals.selectedTeacher?['name']}/${fileName.name}';
      final file = File(fileName.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });
      final snapshot = await uploadTask!.whenComplete(() {});

      final pathImageUrl = await snapshot.ref.getDownloadURL();

      globals.selectedTeacher?.reference.update({'image': pathImageUrl});

      uploadTask = null;
      Toast.show("Успешно!");
    }

    selectImageGallery() async {
      final returnImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (returnImage == null) {
        Toast.show("Вы не выбрали изображение!");
        return;
      }

      setState(() {
        uploadFile(returnImage);
        fileName = returnImage;
      });

      Toast.show("вы выбрали изображение");
    }

    return AlertDialog(
      scrollable: true,
      backgroundColor: appBarBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            globals.typeAction != 'edit'
                ? 'Добавить преподавателя'
                : 'Редактировать преподавателя',
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'bebasRegular'),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (globals.typeAction != 'add')
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                child: FloatingActionButton(
                  onPressed: () {
                    selectImageGallery();
                  },
                  backgroundColor: Colors.white,
                  child: const Text(
                    'Загрузить изображение',
                    style: TextStyle(
                        color: appBarBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'bebasRegular'),
                  ),
                )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Имя',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          TextField(
            controller: surnameController,
            decoration: const InputDecoration(
              labelText: 'Фаимлия',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.05,
            child: FloatingActionButton(
              onPressed: () async {
                if (globals.typeAction == 'edit') {
                  globals.selectedTeacher!.reference.update({
                    'name': nameController.text,
                    'surname': surnameController.text,
                  });
                  Navigator.pop(context);
                  Toast.show('Успешно изменено!');
                  return;
                }

                db.collection('teachers').add({
                  'name': nameController.text,
                  'surname': surnameController.text,
                  'image': '',
                });
                Navigator.pop(context);
                Toast.show('Преподаватель успешно добавлен!');
              },
              backgroundColor: Colors.white,
              child: const Text(
                'Сохранить',
                style: TextStyle(
                    color: appBarBackground,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bebasRegular',
                    fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
