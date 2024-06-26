import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
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
      appBar: AppBar(
        leadingWidth: 180,
        leading: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset('assets/images/logo.png')
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: appBarBackground,
        actions: [
          IconButton(onPressed: (){
            Navigator.popAndPushNamed(context, '/');
          },
          icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
          )
        ],
      ),

      body: 
      SingleChildScrollView(child: 
        Container(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
          child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ПРО НАШУ КОМПАНИЮ', style: TextStyle(
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
                'Мы являемся ведущей компанией в области продажи техники и предлагаем широкий ассортимент продуктов,' +
                 'чтобы удовлетворить различные потребности наших клиентов. Мы предлагаем самые последние модели и' +
                 ' инновационные устройства от ведущих производителей, чтобы обеспечить нашим клиентам высокое качество и надежность.',
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
                'Наша команда экспертов всегда готова предоставить профессиональную консультацию и помочь вам выбрать оптимальное решение,' +
                 'соответствующее вашим потребностям и бюджету. Мы сотрудничаем с частными лицами, фирмами и организациями,' +
                  'обеспечивая высокий уровень обслуживания и гарантируя полное удовлетворение наших клиентов.',
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
                'Наша цель - сделать вашу покупку простой, безопасной и приятной, обеспечивая высокое качество продукции и качественное обслуживание.',
                style: TextStyle(
                  color: lightAppBarBackground
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                Image.asset('assets/logo.png'),
              ],),
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUN0YDQuNC6INGA0L7Quw%3D%3D');
                      await launchUrl(url);
                    },
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    child: Image.asset('assets/WK.png'),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUN0YDQuNC6INGA0L7Quw%3D%3D');
                      await launchUrl(url);
                    },
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    child: Image.asset('assets/YouTube.png'),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUN0YDQuNC6INGA0L7Quw%3D%3D');
                      await launchUrl(url);
                      
                    },
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    child: Image.asset('assets/Telegram.png'),
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