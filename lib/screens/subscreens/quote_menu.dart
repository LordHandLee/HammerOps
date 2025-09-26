import 'package:flutter/material.dart';
import 'package:hammer_ops/screens/subscreens/template_quote_list.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/di/injector.dart';


import 'package:hammer_ops/database/database.dart';

class QuoteMenu extends StatelessWidget {
  final List<String> quotes = [
    "The best way to get started is to quit talking and begin doing.",
    "Don't let yesterday take up too much of today.",
    "It's not whether you get knocked down, it's whether you get up.",
    "If you are working on something exciting, it will keep you motivated.",
    "Success is not in what you have, but who you are.",
  ];
  QuoteMenu({super.key});
  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final AppService service = getIt<AppService>();
    // final Future<List<JobQuote>> quotesFuture = await service.quote.getAllQuotes();
    // // print("Quotes fetched ${quotesFuture[0].id}");
    // print(quotesFuture.);
    return FutureBuilder<List<JobQuote>>(
      future: service.quote.getAllQuotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        print(snapshot.data);
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('No quotes found.'),
          ElevatedButton(
                onPressed: () {
                  // 👇 This pushes onto the nested Navigator
                  Navigator.of(context).pushNamed('/create');
                },
                child: const Text('Create Quote'),
              )]));
        }
        final quotes = snapshot.data!.map((q) => q).toList();
        if (quotes.isEmpty) {
          return const Center(child: Text('No quotes available.'));
        }
        print(quotes.isEmpty);
        print(quotes);
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
              SizedBox(
                height: 400, // container height
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: quotes.length,
                  padding: const EdgeInsets.only(top: 40, bottom: 40),
                  itemBuilder: (context, index) {
                    return Transform.translate(
                      offset: Offset(0, -index * 40.0), // 👈 controls overlap
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        padding: const EdgeInsets.all(16),
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 28,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${quotes[index].customerName.toString()} - \$${quotes[index].totalAmount.toString()} ${quotes[index].quoteDate.toString().split(' ')[0]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF1A2C50),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(
              //   height: 300, // limit height
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: List.generate(quotes.length, (index) {
              //       final quote = quotes[index];
              //       return Positioned(
              //         top: index * 40.0, // 👈 vertical stagger
              //         child: Container(
              //           width: 300,
              //           height: 120,
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(12),
              //             boxShadow: const [
              //               BoxShadow(
              //                 color: Colors.black26,
              //                 blurRadius: 8,
              //                 offset: Offset(0, 4),
              //               )
              //             ],
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(16.0),
              //             child: Text(
              //               quote,
              //               style: const TextStyle(
              //                 color: Colors.indigo,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //         ),
              //       );
              //     }).reversed.toList(), // 👈 reverse so bottom one is on top
              //   ),
              // ),
              // CarouselView.weighted(flexWeights: const <int>[1], children: [TemplateList(templateService: service.template)],),
              // TemplateList(templateService: service.template),
                // SizedBox(
                //   height: 200, // adjust height as needed
                //   child: CarouselView.weighted(
                //     scrollDirection: Axis.vertical,
                //     flexWeights: const <int>[3, 1], // example weights
                //     itemSnapping: true,
                //     children: quotes.map((q) {
                //       return Container(
                //         padding: const EdgeInsets.all(16),
                //         color: Colors.white,
                //         child: Center(
                //           child: Text(
                //             q,
                //             style: TextStyle(color: Colors.blueGrey[800], fontSize: 16),
                //             textAlign: TextAlign.center,
                //           ),
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // ),
              // const Text(
              //   "LOAD QUOTE",
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 20.0,
              //       fontWeight: FontWeight.bold),
              // ),
              // const Text(
              //   "CREATE QUOTE",
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 20.0,
              //       fontWeight: FontWeight.bold),
              // ),
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
      },
    );
  }
}
  
  

