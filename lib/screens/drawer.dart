import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final bool isDrawerOpen;
  final int selectedIndex;
  // final Function(int) onSelectItem;
  final ValueChanged<int> onSelectItem;

  const MyDrawer({
    super.key,
    required this.isDrawerOpen,
    required this.selectedIndex,
    required this.onSelectItem,
    });

  @override
    Widget build(BuildContext context) {
      
      // return Builder(
      //   builder: (context) {
      //     final media = MediaQuery.of(context);
      //     final topPad = kToolbarHeight + media.padding.top;                 // AppBar + status bar
      //     final bottomPad = kBottomNavigationBarHeight + media.padding.bottom; // Bottom nav + gesture inset
      //     final availableHeight = media.size.height- topPad - bottomPad;
      final media = MediaQuery.of(context);
      final topPad = kToolbarHeight + media.padding.top;                 // AppBar + status bar
      final bottomPad = kBottomNavigationBarHeight + media.padding.bottom; // Bottom nav + gesture inset
      final availableHeight = media.size.height- topPad - bottomPad;

      // IMPORTANT: because this widget is intended to be placed inside the Scaffold.body Stack,
      // top=0 aligns it flush under the AppBar (the Scaffold already pushes body below the AppBar).
      final double openTop = 0.0;
      final double closedTop = -availableHeight; // move it completely above the body when closed


      return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: isDrawerOpen ? openTop : closedTop, // hidden above AppBar
      // bottom: -bottomPad,
      left: 0,
      right: 0,
      height: availableHeight,
      child: Material(
        elevation: 16,
        color: const Color.fromARGB(205, 195, 189, 170),
        // child: SafeArea(
        //   top: false, // already handled by padding
        //   bottom: false,
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
                title: const Text('QUOTE'),
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
            
          // ),
        ),
      );
    }
}


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


//         },
//       );
//     }
// }