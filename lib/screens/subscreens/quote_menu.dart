import 'package:flutter/material.dart';
import 'package:hammer_ops/screens/subscreens/template_quote_list.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/di/injector.dart';

class QuoteMenu extends StatelessWidget {
  const QuoteMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final AppService service = getIt<AppService>();

    return Center(
      child: Container(
        width: screenWidth * 0.6,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 39, 63, 82),
          border: Border.all(
            width: 25,
            color: const Color.fromARGB(255, 39, 63, 82),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            // CarouselView.weighted(flexWeights: const <int>[1], children: [TemplateList(templateService: service.template)],),
            // TemplateList(templateService: service.template),
            const Text(
              "LOAD QUOTE",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "CREATE QUOTE",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // 👇 This pushes onto the nested Navigator
                Navigator.of(context).pushNamed('/create');
              },
              child: const Text('Create Quote'),
            )
          ],
        ),
      ),
    );
  }
}
