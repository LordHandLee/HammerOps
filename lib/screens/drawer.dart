import 'package:flutter/material.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/quote__craft/quote_craft.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/tool_tracker.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/job_manager.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/maintain_fleet.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/task_shield.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/flag_task.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/injury_log.dart';

class MyDrawer extends StatefulWidget {
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
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final GlobalKey<NavigatorState> _drawerNavigatorKey = GlobalKey<NavigatorState>();


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
      top: widget.isDrawerOpen ? openTop : closedTop, // hidden above AppBar
      // bottom: -bottomPad,
      left: 0,
      right: 0,
      height: availableHeight,
      child: Material(
        elevation: 16,
        color: const Color.fromARGB(205, 195, 189, 170),
        child: Navigator(
          key: _drawerNavigatorKey,
          onGenerateRoute: (settings) {
            // default route = drawer menu
            return MaterialPageRoute(
              builder: (context) => _DrawerMenu(
                onNavigate: (Widget page) {
                  _drawerNavigatorKey.currentState!.push(
                    MaterialPageRoute(builder: (_) => page),
                  );
                },
              ),
            );
          },
        )
        // child: SafeArea(
        //   top: false, // already handled by padding
        //   bottom: false,

          // child: ListView(
          //   padding: EdgeInsets.zero,
          //   children: [
          //     const Padding(
          //       padding: EdgeInsets.all(16),
          //       child: Text(
          //         'Drawer Header',
          //         style: TextStyle(color: Colors.white, fontSize: 24),
          //       ),
          //     ),
          //     ListTile(
          //       leading: const Icon(Icons.home),
          //       title: const Text('QUOTE'),
          //       selected: selectedIndex == 0,
          //       onTap: () => onSelectItem(0),
          //     ),
          //     ListTile(
          //       leading: const Icon(Icons.settings),
          //       title: const Text('Settings'),
          //       selected: selectedIndex == 1,
          //       onTap: () => onSelectItem(1),
          //       ),
          //     ListTile(
          //     leading: const Icon(Icons.settings),
          //     title: const Text('Settings'),
          //     selected: selectedIndex == 1,
          //     onTap: () => onSelectItem(1),
          //     ),
          //   ],
          //     ),
            
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




class _DrawerMenu extends StatelessWidget {
  final ValueChanged<Widget> onNavigate;

  const _DrawerMenu({Key? key, required this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Drawer Header',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        // ListTile(
        //   leading: const Icon(Icons.home),
        //   title: const Text('Home'),
        //   onTap: () => onNavigate(const DrawerSubPage(title: "Home Page")),
        // ),
        // ListTile(
        //   leading: const Icon(Icons.settings),
        //   title: const Text('Settings'),
        //   onTap: () => onNavigate(const DrawerSubPage(title: "Settings Page")),
        // ),
        // ListTile(
        //   leading: const Icon(Icons.settings),
        //   title: const Text('QUOTE CRAFT'),
        //   onTap: () => onNavigate(const QuoteCraft()),
        // ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('TOOL TRACKER'),
          onTap: () => onNavigate(const ToolTracker()),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('JOB MANAGER'),
          onTap: () => onNavigate(const JobManager()),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('MAINTAIN FLEET'),
          onTap: () => onNavigate(FleetMaintenanceScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('TASK SHIELD'),
          onTap: () => onNavigate(AddEditComplaintScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('FLAG TASK'),
          onTap: () => onNavigate(FlagTaskScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('INJURY LOG'),
          onTap: () => onNavigate(InjuryFormScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('CHECKLIST'),
          onTap: () => onNavigate(const JobManager()),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('SATELLITE MAP'),
          onTap: () => onNavigate(const JobManager()),
        ),
      ],
    );
  }
}

class DrawerSubPage extends StatelessWidget {
  final String title;

  const DrawerSubPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: Text(title),
      ),
      body: Center(
        child: Text("This is $title"),
      ),
    );
  }
}
