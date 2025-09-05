import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      
      return Builder(
        builder: (context) {
          final media = MediaQuery.of(context);
          final topPad = kToolbarHeight + media.padding.top;                 // AppBar + status bar
          final bottomPad = kBottomNavigationBarHeight + media.padding.bottom; // Bottom nav + gesture inset

          return Padding(
            padding: EdgeInsets.only(top: topPad, bottom: bottomPad),
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: media.size.width, // typical drawer width; adjust as you like
                child: Material(
                  elevation: 16,
                  color: const Color.fromARGB(205, 195, 189, 170),
                  child: SafeArea(
                    top: false,  // we already applied the top padding above
                    bottom: false,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: const [
                        // Build your own header (no DrawerHeader; it's the one that
                        // ignores top padding internally)
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Drawer Header',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                        ListTile(leading: Icon(Icons.home), title: Text('Home')),
                        ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
}