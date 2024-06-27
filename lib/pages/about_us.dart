import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: 
      SingleChildScrollView(child: 
        Container(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
          child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('О НАШЕЙ СТУДИИ', style: TextStyle(
                color: appBarBackground,
                fontWeight: FontWeight.bold,
                fontSize: 18
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
                "Наша студия растяжки - это место, где вы можете найти мир и равновесие в своей жизни. Мы создали уникальную атмосферу, которая поможет вам расслабиться и достичь новых высот в вашем физическом и эмоциональном благополучии. Наш опытный персонал и современное оборудование обеспечат вам безопасное и эффективное обучение.",
                style: TextStyle(
                  color: lightAppBarBackground
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('ПРО НАШУ КОМАНДУ', style: TextStyle(
                color: appBarBackground,
                fontWeight: FontWeight.bold,
                fontSize: 18
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
                'Наша команда - это группа опытных и страстных инструкторов, которые посвятили свою жизнь развитию и улучшению физического и эмоционального благополучия людей. Мы постоянно обучаемся и совершенствуем свои навыки, чтобы обеспечить вам лучший опыт растяжки. Наша команда - это ваше поддержка на пути к здоровью и счастью.',
                style: TextStyle(
                  color: lightAppBarBackground
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('НАША ЦЕЛЬ', style: TextStyle(
                color: appBarBackground,
                fontWeight: FontWeight.bold,
                fontSize: 18
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                // ignore: prefer_interpolation_to_compose_strings
                'Наша цель - создать сообщество, где люди могут поддерживать и вдохновлять друг друга на пути к здоровью и счастью.',
                style: TextStyle(
                  color: lightAppBarBackground
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUN0YDQuNC6INGA0L7Quw%3D%3D');
                      await launchUrl(url);
                    },
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    child: Image.asset('assets/images/VK.png'),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUN0YDQuNC6INGA0L7Quw%3D%3D');
                      await launchUrl(url);
                    },
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    child: Image.asset('assets/images/YouTube-100.png'),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUN0YDQuNC6INGA0L7Quw%3D%3D');
                      await launchUrl(url);
                      
                    },
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    child: Image.asset('assets/images/Telegram.png'),
                  )
                ],
              )
              ],
            ),
        )
      )
    );
  }
}