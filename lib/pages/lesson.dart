import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/widgets/app_bar.dart';
import 'package:flutter_stretching_studio/global.dart' as globals;

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
            child: globals.selectedLesson!.get('image') == ''
                ? Center(
                    child: CircularProgressIndicator(
                      color: appBarBackground,
                    ),
                  )
                : Center(
                    child: Image.network(globals.selectedLesson!.get('image')),
                  ),
          ),
        ));
  }
}
