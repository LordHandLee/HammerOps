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
  final GlobalKey _topBarKey = GlobalKey();
  final GlobalKey _bottomBarKey = GlobalKey();

  double topBarHeight = 0;
  double bottomBarHeight = 0;

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

//   @override
//   Widget build(BuildContext context) {
//      final screenHeight = MediaQuery.of(context).size.height;
//     final appBarHeight = kToolbarHeight;
//     final navBarHeight = kBottomNavigationBarHeight;
//     final availableHeight = screenHeight - appBarHeight - navBarHeight;

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Expandable Tiles')),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
//           ],
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: List.generate(5, (index) {
//                 return ConstrainedBox(
//                   constraints: BoxConstraints(
//                     minHeight: availableHeight / 5, // each tile fills 1/5 of space
//                   ),
//                   child: ExpansionTile(
//                     title: Text('Tile ${index + 1}'),
//                     children: [
//                       Container(
//                         height: 250, // expanded content height
//                         color: Colors.grey[300],
//                         child: Center(child: Text('Content ${index + 1}')),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
  
// }

@override
  Widget build(BuildContext context) {
    // compute available height between AppBar and BottomNavigationBar (account for system padding)
    final media = MediaQuery.of(context);
    final appBarHeight = kToolbarHeight;
    final navBarHeight = kBottomNavigationBarHeight;
    final availableHeight = media.size.height
        - appBarHeight
        - navBarHeight
        - media.padding.top
        - media.padding.bottom;

    final collapsedHeight = availableHeight / 6;

    return Scaffold(
      appBar: AppBar(
          leading: Image.asset(
            'images/logo.png', // URL for network image
            width: 40,
            height: 40,
          ),
          title: const Text('Snug Expansion Tiles')),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Apps'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Settings'),
          // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Settings'),
        ],
      ),
      body: SafeArea(
        // scrollable column so expanded tiles can push content and we can scroll
        child: SingleChildScrollView(
          child: Column(
            children: [
              SnugTile(
                title: "OPS BOARD", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.dashboard,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Colors.blueGrey[400]!,
              ),
              SnugTile(
                title: "BRIEFCASE", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.work,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Colors.blueGrey[500]!,
              ),
              SnugTile(
                title: "TASK LIST", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.check_circle,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Colors.blueGrey[600]!,
              ),
              SnugTile(
                title: "SUPPLY DECK", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.inventory,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Colors.blueGrey[700]!,
              ),
              SnugTile(
                title: "SECURE PAY", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.lock,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Colors.blueGrey[800]!,
              ),
              SnugTile(
                title: "MY TEAM", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.contacts,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Colors.blueGrey[900]!,
              ),
            ]
          ),
        ),
      ),
    );
  }
}

/// A tiny custom expansion tile that has NO gaps, and animates height changes.
/// Uses AnimatedSize (requires a TickerProvider) to smoothly animate expansion.
class SnugTile extends StatefulWidget {
  final String title;
  final double collapsedHeight;
  final double expandedContentHeight;

  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color container_color;

  const SnugTile({
    super.key,
    required this.title,
    required this.collapsedHeight,
    required this.expandedContentHeight,
    this.icon = Icons.circle,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
    this.container_color = Colors.white,
  });

  @override
  State<SnugTile> createState() => _SnugTileState();
}

class _SnugTileState extends State<SnugTile> with SingleTickerProviderStateMixin {
  bool _open = false;

  void _toggle() => setState(() => _open = !_open);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: Container(
        // NO margin/padding so tiles touch exactly
        width: double.infinity,
        color: widget.container_color, // change if you want alternating colors
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header area: sized to the collapsedHeight so 5 tiles fill the screen
            InkWell(
              onTap: _toggle,
              child: SizedBox(
                height: widget.collapsedHeight,
                child: Padding(
                  // internal padding for the header contents only (not layout spacing)
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(widget.icon, color: widget.iconColor),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Center(child: Text(widget.title, style: TextStyle(fontSize: 18, color: widget.textColor,))),
                      ),
                      // rotate the chevron when open
                      // AnimatedRotation(
                      //   turns: _open ? 0.5 : 0.0,
                      //   duration: const Duration(milliseconds: 200),
                      //   // child: const Icon(Icons.expand_more),
                      // ),
                    ],
                  ),
                ),
              ),
            ),

            // Expanded content: only present when _open (AnimatedSize will animate)
            if (_open)
              Container(
                width: double.infinity,
                // height of the extra content when open
                height: widget.expandedContentHeight,
                color: Colors.grey[100],
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Expanded content for ${widget.title}. '
                  'Put any widgets you want here (forms, lists, images, etc.).',
                  style: TextStyle(color: widget.textColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


