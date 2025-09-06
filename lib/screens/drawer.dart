import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final bool isDrawerOpen;
  final int selectedIndex;
  final Function(int) onSelectItem;

  const MyDrawer({
    super.key,
    required this.isDrawerOpen,
    required this.selectedIndex,
    required this.onSelectItem,
    });

  @override
    Widget build(BuildContext context) {
      
      return Builder(
        builder: (context) {
          final media = MediaQuery.of(context);
          final topPad = kToolbarHeight + media.padding.top;                 // AppBar + status bar
          final bottomPad = kBottomNavigationBarHeight + media.padding.bottom; // Bottom nav + gesture inset
          final availableHeight = media.size.height - topPad - bottomPad;

          return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: isDrawerOpen ? topPad : -availableHeight, // hidden above AppBar
          left: 0,
          right: 0,
          height: availableHeight,
          child: Material(
            elevation: 16,
            color: const Color.fromARGB(205, 195, 189, 170),
            child: SafeArea(
              top: false, // already handled by padding
              bottom: false,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Drawer Header',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    selected: selectedIndex == 0,
                    onTap: () => onSelectItem(0),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    selected: selectedIndex == 1,
                    onTap: () => onSelectItem(1),
                    ),
                    ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    selected: selectedIndex == 1,
                    onTap: () => onSelectItem(1),
                    ),
                ],
                  ),
                
              ),
            ),
          );

          // return Padding(
          //   padding: EdgeInsets.only(top: topPad, bottom: bottomPad),
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: SizedBox(
          //       width: media.size.width, // typical drawer width; adjust as you like
          //       child: Material(
          //         elevation: 16,
          //         color: const Color.fromARGB(205, 195, 189, 170),
          //         child: SafeArea(
          //           top: false,  // we already applied the top padding above
          //           bottom: false,
          //           child: ListView(
          //             padding: EdgeInsets.zero,
          //             children: const [
          //               // Build your own header (no DrawerHeader; it's the one that
          //               // ignores top padding internally)
          //               Padding(
          //                 padding: EdgeInsets.all(16),
          //                 child: Text(
          //                   'Drawer Header',
          //                   style: TextStyle(color: Colors.white, fontSize: 24),
          //                 ),
          //               ),
          //               ListTile(leading: Icon(Icons.home), title: Text('Home')),
          //               ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // );
        },
      );
    }
}