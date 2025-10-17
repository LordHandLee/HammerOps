import 'package:flutter/material.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/tool_creator.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/tool.dart';
class ToolTracker extends StatelessWidget {

  // const ToolTracker(Key? key) : super(key: key);
  const ToolTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: Text("Tool Tracker"),
      ),
      body: Row(
        children: [
        Column(
          children: [
            ElevatedButton(
              // opens tool creation screen. tool added to list upon creation
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ToolCreator(),
                  ),
                );
              },
              child: const Text('CREATE TOOL'),),
            const SizedBox(height: 16),
            ElevatedButton(
                // opens tool creation screen. tool added to list upon creation
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ToolCreator(),
                    ),
                  );
                },
                child: const Text('CHECKOUT TOOL'),),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          // need to get list of tools from database
          // needs to be listview.builder
          // when click on ListTile, navigate to corresponding tool page using tool id
          child: ListView(
            children: [
              // tool widget
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('TOOL 1'),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Tool(),
                  ),
                ), //onNavigate(const ToolTracker()),
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}
