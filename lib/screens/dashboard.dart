import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey _topBarKey = GlobalKey();
  final GlobalKey _bottomBarKey = GlobalKey();


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

    return SafeArea(
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
                container_color: Color.fromARGB(255, 86, 124, 155),
                expanded_color: Color.fromARGB(255, 86, 124, 155),
              ),
              SnugTile(
                title: "BRIEFCASE", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.work,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Color.fromARGB(255, 59, 87, 110),
                expanded_color: Color.fromARGB(255, 59, 87, 110),
              ),
              SnugTile(
                title: "TASK LIST", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.check_circle,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Color.fromARGB(255, 28, 46, 60),
                expanded_color: Color.fromARGB(255, 28, 46, 60),
              ),
              SnugTile(
                title: "SUPPLY DECK", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.inventory,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Color.fromARGB(255, 32, 43, 60),
                expanded_color: Color.fromARGB(255, 32, 43, 60),
              ),
              SnugTile(
                title: "SECURE PAY", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.lock,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Color.fromARGB(255, 25, 30, 44),
                expanded_color: Color.fromARGB(255, 25, 30, 44),
              ),
              SnugTile(
                title: "MY TEAM", 
                collapsedHeight: collapsedHeight,
                expandedContentHeight: 180,
                icon: Icons.contacts,
                iconColor: Colors.white,
                textColor: Colors.white,
                container_color: Color.fromARGB(255, 18, 24, 33),
                expanded_color: Color.fromARGB(255, 18, 24, 33),
              ),
            ]
          ),
        ),
      );
  }
}


class SnugTile extends StatefulWidget {
  final String title;
  final double collapsedHeight;
  final double expandedContentHeight;

  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color container_color;
  final Color expanded_color;

  const SnugTile({
    super.key,
    required this.title,
    required this.collapsedHeight,
    required this.expandedContentHeight,
    this.icon = Icons.circle,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
    this.container_color = Colors.white,
    this.expanded_color = Colors.grey, // default color for expanded area
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
                color: widget.expanded_color,
                padding: const EdgeInsets.all(16),
                // child: BarChart(
                //   BarChartData(
                //     // read about it in the BarChartData section
                //   ),
                //   duration: Duration(milliseconds: 150), // Optional
                //   curve: Curves.linear, // Optional
                // ),
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

