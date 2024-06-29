import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/database/collections/ProfileCollection';
import 'package:flutter_stretching_studio/navigation_bar.dart';
import 'package:flutter_stretching_studio/global.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

final ProfileCollection profile = ProfileCollection();
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

void initLang() async {
  await initializeDateFormatting('ru_RU');
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    initLang();
    return Scaffold(
      floatingActionButton: Container(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
        child: FloatingActionButton(
          backgroundColor: appBarBackground,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return alertLesson();
                });
          },
        ),
      ),
      key: _scaffoldkey,
      endDrawer: const Navbar(),
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              globals.selectedTeacher == null
                  ? IconButton(
                      onPressed: () {
                        _scaffoldkey.currentState?.openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ))
                  : IconButton(
                      onPressed: () {
                        globals.selectedTeacher = null;
                        Navigator.popAndPushNamed(context, '/');
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      )),
            ],
          ),
        ],
        leadingWidth: 180,
        leading: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset('assets/images/logo.png')
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: appBarBackground,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          for (int i = 0; i < 14; i++)
            Card(
              child: Center(
                child: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: StreamBuilder(
                            stream: globals.selectedTeacher == null
                                ? db
                                    .collection('lessons')
                                    .where('date',
                                        isEqualTo: DateFormat('dd.MM')
                                            .format(DateTime.now()
                                                .add(Duration(days: i)))
                                            .toString())
                                    .snapshots()
                                : db
                                    .collection('lessons')
                                    .where('date',
                                        isEqualTo: DateFormat('dd.MM')
                                            .format(DateTime.now()
                                                .add(Duration(days: i)))
                                            .toString())
                                    .where('teacher',
                                        isEqualTo: globals.selectedTeacher!.id)
                                    .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        color: appBarBackground,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "С ",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'bebasRegular',
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                                .get(
                                                                    'fromTime') +
                                                            '   ',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'bebasRegular',
                                                            fontSize: 14),
                                                      ),
                                                      const Text(
                                                        "По ",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'bebasRegular',
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .get('toTime'),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'bebasRegular',
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                                .get('name') +
                                                            '   ',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'bebasRegular',
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .get('teacherName'),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'bebasRegular',
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                child: FloatingActionButton(
                                                  onPressed: () {
                                                    globals.selectedLesson =
                                                        snapshot
                                                            .data!.docs[index];
                                                    Navigator.popAndPushNamed(
                                                        context, '/lesson');
                                                  },
                                                  backgroundColor: Colors.white,
                                                  child: const Text(
                                                      'Записаться',
                                                      style: TextStyle(
                                                          color:
                                                              appBarBackground,
                                                          fontFamily:
                                                              'bebasRegular',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.ease);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: appBarBackground,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              DateFormat('EEEE', 'ru_RU').format(
                                  DateTime.now().add(Duration(days: i))),
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'bebasregular',
                                  color: appBarBackground),
                            ),
                            Text(
                              DateFormat('dd.MM')
                                  .format(DateTime.now().add(Duration(days: i)))
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'bebasregular',
                                  color: appBarBackground),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () async {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.ease);
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: appBarBackground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

UploadTask? uploadTask;

class alertLesson extends StatefulWidget {
  const alertLesson({super.key});

  @override
  State<alertLesson> createState() => _alertLessonState();
}

class _alertLessonState extends State<alertLesson> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  selectImageGallery(String typeImageToLoad) async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) {
      Toast.show("Вы не выбрали изображение!");
      return;
    }

    uploadFile(returnImage, typeImageToLoad);
    Toast.show("вы выбрали изображение");
  }

  Future uploadFile(XFile fileName, String typeImageToLoad) async {
    final path = 'lessons/${fileName.name}';
    final file = File(fileName.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final pathImageUrl = await snapshot.ref.getDownloadURL();

    globals.imageUrl = pathImageUrl;

    setState(() {
      uploadTask = null;
      Toast.show("Успешно!");
    });
  }

  DateTime _selectedDate = DateTime.now();
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void setTeacher(String id) async {
    QuerySnapshot querySnapshot = await db.collection('teachers').get();
    for (var doc in querySnapshot.docs) {
      if (doc.id == id) {
        globals.selectedTeacherDrop = doc;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    bool isValid(String value) {
      final RegExp timeRegex = RegExp(r'^([0-9]|1[0-9]|2[0-3]):([0-5][0-9])$');
      return timeRegex.hasMatch(value);
    }

    return AlertDialog(
      scrollable: true,
      backgroundColor: appBarBackground,
      title: Center(
        child: Text(
          'Добавить занятие',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'bebasRegular',
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),
      content: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('teachers').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DropdownButtonFormField(
                  dropdownColor: appBarBackground,
                  iconEnabledColor: Colors.white,
                  items: snapshot.data?.docs.map((document) {
                    return DropdownMenuItem(
                      value: document.id,
                      child: Text(
                        document.get('surname') + " " + document.get('name'),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'bebasRegular',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setTeacher(value!);
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.05,
              child: FloatingActionButton(
                onPressed: () {
                  selectImageGallery('MainImage');
                },
                backgroundColor: Colors.white,
                child: const Text(
                  'Загрузить основное изображение',
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
              labelText: 'Название',
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
            controller: countController,
            decoration: const InputDecoration(
              labelText: 'Количество записей',
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
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Описание',
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
          TextField(
            controller: fromController,
            decoration: const InputDecoration(
              labelText: 'Время начала занятия',
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
          TextField(
            controller: toController,
            decoration: const InputDecoration(
              labelText: 'Время конца занятия',
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
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.05,
                child: FloatingActionButton(
                  onPressed: () async {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 14)),
                    ).then((date) {
                      setState(() {
                        _selectedDate = date!;
                      });
                    });
                  },
                  backgroundColor: Colors.white,
                  child: const Text(
                    'Выбрать дату',
                    style: TextStyle(
                        color: appBarBackground,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'bebasRegular',
                        fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                DateFormat('dd.MM').format(_selectedDate).toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'bebasRegular',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.05,
            child: FloatingActionButton(
              onPressed: () async {
                if (globals.selectedTeacherDrop == null ||
                    nameController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    countController.text.isEmpty ||
                    fromController.text.isEmpty ||
                    toController.text.isEmpty) {
                  Toast.show('Заполните все поля!');
                  return;
                }

                if (!isValid(fromController.text) ||
                    !isValid(toController.text)) {
                  Toast.show('Заполните время правильно!');
                  return;
                }

                db.collection('lessons').add({
                  'name': nameController.text,
                  'count': countController.text,
                  'description': descriptionController.text,
                  'image': globals.imageUrl == "" || globals.imageUrl == null
                      ? ""
                      : globals.imageUrl,
                  'fromTime': fromController.text,
                  'toTime': toController.text,
                  'teacher': globals.selectedTeacherDrop!.id,
                  'teacherName': globals.selectedTeacherDrop!.get('name'),
                  'date': DateFormat('dd.MM').format(_selectedDate)
                });
                Navigator.pop(context);
                Toast.show('Товар успешно добавлен!');

                globals.imageUrl = "";
                globals.selectedTeacherDrop = null;
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
