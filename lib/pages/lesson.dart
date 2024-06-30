import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/widgets/app_bar.dart';
import 'package:flutter_stretching_studio/global.dart' as globals;
import 'package:toast/toast.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  globals.selectedLesson!.get('name'),
                  style: const TextStyle(
                      color: appBarBackground,
                      fontFamily: 'bebasRegular',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      'C ',
                      style: TextStyle(
                          color: appBarBackground,
                          fontFamily: 'bebasRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      globals.selectedLesson!.get('fromTime'),
                      style: const TextStyle(
                          color: appBarBackground,
                          fontFamily: 'bebasRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'До ',
                      style: TextStyle(
                          color: appBarBackground,
                          fontFamily: 'bebasRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      globals.selectedLesson!.get('toTime'),
                      style: const TextStyle(
                          color: appBarBackground,
                          fontFamily: 'bebasRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
                Text(
                  globals.selectedLesson!.get('teacherName'),
                  style: const TextStyle(
                      color: appBarBackground,
                      fontFamily: 'bebasRegular',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 30),
                Center(
                  child: globals.action != "myLessons"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (globals.selectedLesson!.get('count') != "0")
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    if (FirebaseAuth.instance.currentUser ==
                                        null) {
                                      Navigator.popAndPushNamed(
                                          context, '/auth');
                                      return;
                                    }

                                    await globals.selectedLesson!.reference
                                        .update({
                                      'count': (int.parse(globals
                                                  .selectedLesson!
                                                  .get('count')) -
                                              1)
                                          .toString()
                                    });

                                    DocumentSnapshot doc =
                                        await FirebaseFirestore.instance
                                            .collection('profiles')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .get();

                                    await doc.reference
                                        .collection('myLessons')
                                        .add({
                                      'name':
                                          globals.selectedLesson!.get('name'),
                                      'description': globals.selectedLesson!
                                          .get('description'),
                                      'image':
                                          globals.selectedLesson!.get('image'),
                                      'fromTime': globals.selectedLesson!
                                          .get('fromTime'),
                                      'toTime':
                                          globals.selectedLesson!.get('toTime'),
                                      'teacher': globals.selectedLesson!
                                          .get('teacher'),
                                      'teacherName': globals.selectedLesson!
                                          .get('teacherName'),
                                      'date':
                                          globals.selectedLesson!.get('date'),
                                      'idLesson': globals.selectedLesson!.id
                                    });
                                    Navigator.popAndPushNamed(context, '/');
                                    Toast.show(
                                        "Вы успешно записались на занятие!");
                                  },
                                  backgroundColor: appBarBackground,
                                  child: const Text(
                                    "Записаться",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'bebasRegular',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 5),
                            Text(
                              globals.selectedLesson!.get('count') != "0"
                                  ? "Осталось мест: " +
                                      globals.selectedLesson!.get('count')
                                  : "Все места заняты",
                              style: const TextStyle(
                                  color: lightAppBarBackground,
                                  fontFamily: 'bebasRegular',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: FloatingActionButton(
                            onPressed: () async {
                              DocumentSnapshot doc = await FirebaseFirestore
                                  .instance
                                  .collection('lessons')
                                  .doc(globals.selectedLesson!.get('idLesson'))
                                  .get();
                              await doc.reference.update({
                                'count':
                                    (int.parse(doc.get('count')) + 1).toString()
                              });
                              await globals.selectedLesson!.reference.delete();
                              Navigator.popAndPushNamed(context, '/');
                              Toast.show("Вы успешно отменили запись!");
                            },
                            backgroundColor: appBarBackground,
                            child: const Text(
                              "Отменить запись",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'bebasRegular',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Описание',
                  style: TextStyle(
                      color: appBarBackground,
                      fontFamily: 'bebasRegular',
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
                Text(
                  globals.selectedLesson!.get('description'),
                  style: const TextStyle(
                      color: appBarBackground,
                      fontFamily: 'bebasRegular',
                      fontSize: 18),
                ),
                const SizedBox(height: 20),
                globals.selectedLesson!.get('image') == ''
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: appBarBackground,
                        ),
                      )
                    : Center(
                        child:
                            Image.network(globals.selectedLesson!.get('image')),
                      ),
              ],
            ),
          ),
        ));
  }
}
