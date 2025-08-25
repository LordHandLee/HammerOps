import 'package:flutter/material.dart';

void main() {
  runApp(const HammerOps());
}

class HammerOps extends StatelessWidget {
  const HammerOps({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Hammer Ops Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 211, 193), // backgjround behind buttons
      body: SafeArea(
        child: Column(
          children: [
            //Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(), // centers the text
                  Text(
                    "\t\t\t\t\t\t\t\t\t\t\tWELCOME\n[COMPANY NAME HERE]",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.menu, size: 28),
                ],
              ),
            ),

            // Button List
            Expanded(
              child: ListView(
                children: [
                  // buildMenuButton("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard ),
                  // buildMenuButton("BRIEFCASE", Colors.blueGrey[500]!, Icons.work),
                  // buildMenuButton("TASK LIST", Colors.blueGrey[600]!, Icons.check_circle),
                  // buildMenuButton("SUPPLY DECK", Colors.blueGrey[700]!, Icons.inventory),
                  // buildMenuButton("SECURE PAY", Colors.blueGrey[800]!, Icons.lock),
                  buildExpandableMenu("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard, [ListTile(title: Text("Project A")),ListTile(title: Text("Project B")),ListTile(title: Text("2025 Profit Margins"))], context),
                  buildExpandableMenu("BRIEFCASE", Colors.blueGrey[500]!, Icons.work, [ListTile(title: Text("Folder 1")), ListTile(title: Text("Folder 2"))], context),
                  buildExpandableMenu("TASK LIST", Colors.blueGrey[600]!, Icons.check_circle, [ListTile(title: Text("Customer A    Pour Concrete")), ListTile(title: Text("Customer B    Remove debris"))], context),
                  buildExpandableMenu("SUPPLY DECK", Colors.blueGrey[700]!, Icons.inventory, [ListTile(title: Text("QUARTERLY_FINANCIALS.PDF")), ListTile(title: Text("SAFETY_GEAR_LIST.PDF")), ListTile(title: Text("PERMIT_TEMPLATE.PDF"))], context),
                  buildExpandableMenu("SECURE PAY", Colors.blueGrey[800]!, Icons.lock, [ListTile(title: Text("Credit Card")), ListTile(title: Text("Invoices"))], context),
                  // buildExpandableMenu("Reports",Colors.blueGrey[800]!,Icons.menu,[ListTile(title: Text("Daily Report")),ListTile(title: Text("Weekly Report")),],),

                ],
              ),
            ),

            // Bottom Navigation
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue[300],
                    child: Icon(Icons.home, color: Colors.white, size: 28),
                  ),
                  Icon(Icons.apps, color: Colors.white, size: 28),
                  Icon(Icons.edit, color: Colors.white, size: 28),
                  Icon(Icons.person, color: Colors.white, size: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Helper widget for menu buttons
  Widget buildMenuButton(String title, Color color, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      height: 80,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(icon, color: Colors.white, size: 28),
        //SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ],
    ),
  );
}

Widget buildExpandableMenu(String title, Color color, IconData icon, List<Widget> children, BuildContext context) {
  return Container(
    height: 80,
    color: color,
    child: ExpansionTile(
      leading: Icon(icon, color: Colors.white, size: 28),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 2,
        ),
        textAlign: TextAlign.center,
      ),
      trailing: SizedBox.shrink(),
      children: children,
    ),
  );
}
}
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
