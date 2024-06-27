import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: 
      SingleChildScrollView(child: 
        Container(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('НАШИ КОНТАКТЫ',
              style: const TextStyle(
                color: appBarBackground, 
                fontFamily: 'bebasRegular',
                fontSize: 25,
              ),),
              const SizedBox(height: 5),
              const Text('Главный тренер Алсу Загитовна +7(987) 229 30-84',
              style: TextStyle(
                color: lightAppBarBackground, 
                fontFamily: 'bebasRegular',
                fontSize: 18,
              ),),
              const Text('АДРЕС',
              style: TextStyle(
                color: appBarBackground, 
                fontFamily: 'bebasRegular',
                fontSize: 25,
              ),),
              const SizedBox(height: 5),
              const Text('пр. Альберта Камалеева, 32б, Казань, Респ. Татарстан, 420087',
              style: TextStyle(
                color: lightAppBarBackground, 
                fontFamily: 'bebasRegular',
                fontSize: 18,
              ),),
              const SizedBox(height: 30),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.asset('assets/images/train.jpg'),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text('✦   ПРИХОДИТЕ К НАМ!   ✦',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appBarBackground, 
                  fontFamily: 'bebasRegular',
                  fontSize: 20,
                ),),
              ),
            ],
          )
        )
      )
    );
  }
}