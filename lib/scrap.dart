//     // TODO 5 rows. each row has expanded containing expandable menu
//     final screenHeight = MediaQuery.of(context).size.height;

//     // Calculate available height
//     final availableHeight =
//         screenHeight - topBarHeight - bottomBarHeight;

//     // Number of expandable menus
//     final menuCount = 5;
//     final menuHeight = availableHeight / menuCount;
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 224, 211, 193), // backgjround behind buttons
//       appBar: AppBar(centerTitle: true, title: const Text("\t\t\t\t\t\t\t\t\t\t\tWELCOME\n[COMPANY NAME HERE]")),
//       body: SingleChildScrollView(
//         // crossAxisAlignment: CrossAxisAlignment.stretch ,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           buildExpandableMenu("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard, [ListTile(title: Text("Project A")),ListTile(title: Text("Project B")),ListTile(title: Text("2025 Profit Margins"))], textStyle: TextStyle(color: Colors.white),),
//           buildExpandableMenu("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard, [ListTile(title: Text("Project A")),ListTile(title: Text("Project B")),ListTile(title: Text("2025 Profit Margins"))], textStyle: TextStyle(color: Colors.white),),
//           buildExpandableMenu("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard, [ListTile(title: Text("Project A")),ListTile(title: Text("Project B")),ListTile(title: Text("2025 Profit Margins"))], textStyle: TextStyle(color: Colors.white),),
//           buildExpandableMenu("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard, [ListTile(title: Text("Project A")),ListTile(title: Text("Project B")),ListTile(title: Text("2025 Profit Margins"))], textStyle: TextStyle(color: Colors.white),),
//           buildExpandableMenu("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard, [ListTile(title: Text("Project A")),ListTile(title: Text("Project B")),ListTile(title: Text("2025 Profit Margins"))], textStyle: TextStyle(color: Colors.white),),
//           // Expanded(child: buildExpandableMenu("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard, [ListTile(title: Text("Project A")),ListTile(title: Text("Project B")),ListTile(title: Text("2025 Profit Margins"))], textStyle: TextStyle(color: Colors.white),)),
//           // Expanded(child: buildExpandableMenu("BRIEFCASE", Colors.blueGrey[500]!, Icons.work, [ListTile(title: Text("Folder 1")), ListTile(title: Text("Folder 2"))], textStyle: TextStyle(color: Colors.white),)),
//           // Expanded(child: buildExpandableMenu("TASK LIST", Colors.blueGrey[600]!, Icons.check_circle, [ListTile(title: Text("Customer A    Pour Concrete")), ListTile(title: Text("Customer B    Remove debris"))], textStyle: TextStyle(color: Colors.white),)),
//           // Expanded(child: buildExpandableMenu("SUPPLY DECK", Colors.blueGrey[700]!, Icons.inventory, [ListTile(title: Text("QUARTERLY_FINANCIALS.PDF")), ListTile(title: Text("SAFETY_GEAR_LIST.PDF")), ListTile(title: Text("PERMIT_TEMPLATE.PDF"))], textStyle: TextStyle(color: Colors.white),)),
//           // Expanded(child: buildExpandableMenu("SECURE PAY", Colors.blueGrey[800]!, Icons.lock, [ListTile(title: Text("Credit Card")), ListTile(title: Text("Invoices"))], textStyle: TextStyle(color: Colors.white),)),
//       ],
//       ))
      
//       // body: SingleChildScrollView(
//       //   // mainAxisAlignment: MainAxisAlignment.end,
//       //   //crossAxisAlignment: CrossAxisAlignment.stretch,
//       //   child: Column(
//       //     children: [
//       //     buildExpandableMenu("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard, [ListTile(title: Text("Project A")),ListTile(title: Text("Project B")),ListTile(title: Text("2025 Profit Margins"))]),
//       //     // Expanded(child: buildExpandableMenu("BRIEFCASE", Colors.blueGrey[500]!, Icons.work, [ListTile(title: Text("Folder 1")), ListTile(title: Text("Folder 2"))])),
//       //     // Expanded(child: buildExpandableMenu("TASK LIST", Colors.blueGrey[600]!, Icons.check_circle, [ListTile(title: Text("Customer A    Pour Concrete")), ListTile(title: Text("Customer B    Remove debris"))])),
//       //     // Expanded(child: buildExpandableMenu("SUPPLY DECK", Colors.blueGrey[700]!, Icons.inventory, [ListTile(title: Text("QUARTERLY_FINANCIALS.PDF")), ListTile(title: Text("SAFETY_GEAR_LIST.PDF")), ListTile(title: Text("PERMIT_TEMPLATE.PDF"))])),
//       //     // Expanded(child: buildExpandableMenu("SECURE PAY", Colors.blueGrey[800]!, Icons.lock, [ListTile(title: Text("Credit Card")), ListTile(title: Text("Invoices"))])),
//       //   ],
//       // )
//       // )
    
//       // body: SafeArea(
//       //   child: LayoutBuilder(
//       //     builder: (context, constraints) {
//       //       final availableHeight =
//       //           constraints.maxHeight - topBarHeight - bottomBarHeight;

//       //       return Column(
//       //         children: [
//       //           // 🔹 Top Bar
//       //           Padding(
//       //             key: _topBarKey,
//       //             padding:
//       //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       //             child: Row(
//       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //               children: [
//       //                 const Spacer(),
//       //                 const Text(
//       //                   "\t\t\t\t\t\t\t\t\t\t\tWELCOME\n[COMPANY NAME HERE]",
//       //                   style: TextStyle(
//       //                     fontWeight: FontWeight.bold,
//       //                     fontSize: 16,
//       //                     letterSpacing: 2,
//       //                   ),
//       //                 ),
//       //                 const Spacer(),
//       //                 const Icon(Icons.menu, size: 28),
//       //               ],
//       //             ),
//       //           ),

//       //           ListView(
//       //             children: [
//       //               buildExpandableMenu(
//       //                 "OPS BOARD",
//       //                 Colors.blueGrey[400]!,
//       //                 Icons.dashboard,
//       //                 [
//       //                   const ListTile(title: Text("Project A")),
//       //                   const ListTile(title: Text("Project B")),
//       //                   const ListTile(title: Text("2025 Profit Margins")),
//       //                 ],
//       //               ),
//       //               buildExpandableMenu(
//       //                 "BRIEFCASE",
//       //                 Colors.blueGrey[500]!,
//       //                 Icons.work,
//       //                 [
//       //                   const ListTile(title: Text("Folder 1")),
//       //                   const ListTile(title: Text("Folder 2")),
//       //                 ],
//       //               ),
//       //               // etc...
//       //             ],
//       //           ),

//                 // 🔹 Menu list that expands + scrolls
//                 // Expanded(
//                 //   child: SingleChildScrollView(
//                 //     child: ConstrainedBox(
//                 //       constraints: BoxConstraints(minHeight: availableHeight),
//                 //       child: IntrinsicHeight(
//                 //         child: Column(
//                 //           children: [
//                 //             Expanded(
//                 //               child: buildExpandableMenu(
//                 //                 "OPS BOARD",
//                 //                 Colors.blueGrey[400]!,
//                 //                 Icons.dashboard,
//                 //                 [
//                 //                   ListTile(title: Text("Project A")),
//                 //                   ListTile(title: Text("Project B")),
//                 //                   ListTile(title: Text("2025 Profit Margins")),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //             Expanded(
//                 //               child: buildExpandableMenu(
//                 //                 "BRIEFCASE",
//                 //                 Colors.blueGrey[500]!,
//                 //                 Icons.work,
//                 //                 [
//                 //                   ListTile(title: Text("Folder 1")),
//                 //                   ListTile(title: Text("Folder 2")),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //             Expanded(
//                 //               child: buildExpandableMenu(
//                 //                 "TASK LIST",
//                 //                 Colors.blueGrey[600]!,
//                 //                 Icons.check_circle,
//                 //                 [
//                 //                   ListTile(
//                 //                       title:
//                 //                           Text("Customer A    Pour Concrete")),
//                 //                   ListTile(
//                 //                       title:
//                 //                           Text("Customer B    Remove debris")),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //             Expanded(
//                 //               child: buildExpandableMenu(
//                 //                 "SUPPLY DECK",
//                 //                 Colors.blueGrey[700]!,
//                 //                 Icons.inventory,
//                 //                 [
//                 //                   ListTile(
//                 //                       title: Text("QUARTERLY_FINANCIALS.PDF")),
//                 //                   ListTile(
//                 //                       title: Text("SAFETY_GEAR_LIST.PDF")),
//                 //                   ListTile(
//                 //                       title: Text("PERMIT_TEMPLATE.PDF")),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //             Expanded(
//                 //               child: buildExpandableMenu(
//                 //                 "SECURE PAY",
//                 //                 Colors.blueGrey[800]!,
//                 //                 Icons.lock,
//                 //                 [
//                 //                   ListTile(title: Text("Credit Card")),
//                 //                   ListTile(title: Text("Invoices")),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),

//         // child: Column(
//         //   children: [
//         //     //Top Bar
//         //     Padding(
//         //       key: _topBarKey,
//         //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         //       child: Row(
//         //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //         children: [
//         //           Spacer(), // centers the text
//         //           Text(
//         //             "\t\t\t\t\t\t\t\t\t\t\tWELCOME\n[COMPANY NAME HERE]",
//         //             style: TextStyle(
//         //               fontWeight: FontWeight.bold,
//         //               fontSize: 16,
//         //               letterSpacing: 2,
//         //             ),
//         //           ),
//         //           Spacer(),
//         //           Icon(Icons.menu, size: 28),
//         //         ],
//         //       ),
//         //     ),

//             // Button List
            
            
//             // Expanded(child: buildExpandableMenu("BRIEFCASE", Colors.blueGrey[500]!, Icons.work, [ListTile(title: Text("Folder 1")), ListTile(title: Text("Folder 2"))], menuHeight)),
//             // Expanded(child: buildExpandableMenu("TASK LIST", Colors.blueGrey[600]!, Icons.check_circle, [ListTile(title: Text("Customer A    Pour Concrete")), ListTile(title: Text("Customer B    Remove debris"))], menuHeight)),
//             // Expanded(child: buildExpandableMenu("SUPPLY DECK", Colors.blueGrey[700]!, Icons.inventory, [ListTile(title: Text("QUARTERLY_FINANCIALS.PDF")), ListTile(title: Text("SAFETY_GEAR_LIST.PDF")), ListTile(title: Text("PERMIT_TEMPLATE.PDF"))], menuHeight)),
//             // Expanded(child: buildExpandableMenu("SECURE PAY", Colors.blueGrey[800]!, Icons.lock, [ListTile(title: Text("Credit Card")), ListTile(title: Text("Invoices"))], menuHeight)))])
//               //child: ListView(
//                 // children: [
//                 //   // buildMenuButton("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard ),
//                 //   // buildMenuButton("BRIEFCASE", Colors.blueGrey[500]!, Icons.work),
//                 //   // buildMenuButton("TASK LIST", Colors.blueGrey[600]!, Icons.check_circle),
//                 //   // buildMenuButton("SUPPLY DECK", Colors.blueGrey[700]!, Icons.inventory),
//                 //   // buildMenuButton("SECURE PAY", Colors.blueGrey[800]!, Icons.lock),
//                 //   buildExpandableMenu("OPS BOARD", Colors.blueGrey[400]!, Icons.dashboard, [ListTile(title: Text("Project A")),ListTile(title: Text("Project B")),ListTile(title: Text("2025 Profit Margins"))], menuHeight),
//                 //   buildExpandableMenu("BRIEFCASE", Colors.blueGrey[500]!, Icons.work, [ListTile(title: Text("Folder 1")), ListTile(title: Text("Folder 2"))], menuHeight),
//                 //   buildExpandableMenu("TASK LIST", Colors.blueGrey[600]!, Icons.check_circle, [ListTile(title: Text("Customer A    Pour Concrete")), ListTile(title: Text("Customer B    Remove debris"))], menuHeight),
//                 //   buildExpandableMenu("SUPPLY DECK", Colors.blueGrey[700]!, Icons.inventory, [ListTile(title: Text("QUARTERLY_FINANCIALS.PDF")), ListTile(title: Text("SAFETY_GEAR_LIST.PDF")), ListTile(title: Text("PERMIT_TEMPLATE.PDF"))], menuHeight),
//                 //   buildExpandableMenu("SECURE PAY", Colors.blueGrey[800]!, Icons.lock, [ListTile(title: Text("Credit Card")), ListTile(title: Text("Invoices"))], menuHeight),
//                 //   // buildExpandableMenu("Reports",Colors.blueGrey[800]!,Icons.menu,[ListTile(title: Text("Daily Report")),ListTile(title: Text("Weekly Report")),],),

//                 // ],
//             //   ),
//             // ),

//             // Bottom Navigation
//     //         Container(
//     //           key: _bottomBarKey,
//     //           padding: EdgeInsets.symmetric(vertical: 10),
//     //           decoration: BoxDecoration(
//     //             color: Colors.black87,
//     //             borderRadius: BorderRadius.only(
//     //               topLeft: Radius.circular(20),
//     //               topRight: Radius.circular(20),
//     //             ),
//     //           ),
//     //           child: Row(
//     //             mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //             children: [
//     //               CircleAvatar(
//     //                 radius: 25,
//     //                 backgroundColor: Colors.blue[300],
//     //                 child: Icon(Icons.home, color: Colors.white, size: 28),
//     //               ),
//     //               Icon(Icons.apps, color: Colors.white, size: 28),
//     //               Icon(Icons.edit, color: Colors.white, size: 28),
//     //               Icon(Icons.person, color: Colors.white, size: 28),
//     //             ],
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );

//     // // 🔹 Bottom Bar
//     //             Container(
//     //               key: _bottomBarKey,
//     //               padding: const EdgeInsets.symmetric(vertical: 10),
//     //               decoration: const BoxDecoration(
//     //                 color: Colors.black87,
//     //                 borderRadius: BorderRadius.only(
//     //                   topLeft: Radius.circular(20),
//     //                   topRight: Radius.circular(20),
//     //                 ),
//     //               ),
//     //               child: Row(
//     //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //                 children: [
//     //                   CircleAvatar(
//     //                     radius: 25,
//     //                     backgroundColor: Colors.blue[300],
//     //                     child: const Icon(Icons.home,
//     //                         color: Colors.white, size: 28),
//     //                   ),
//     //                   const Icon(Icons.apps, color: Colors.white, size: 28),
//     //                   const Icon(Icons.edit, color: Colors.white, size: 28),
//     //                   const Icon(Icons.person, color: Colors.white, size: 28),
//     //                 ],
//     //               ),
//     //             ),
//     //           ],
//     //         );
//     //       },
//     //     ),
//     //   ),
//     // );
//     );
//   }
  
//   // Helper widget for menu buttons
//   Widget buildMenuButton(String title, Color color, IconData icon) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//       height: 80,
//       decoration: BoxDecoration(
//         color: color,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//         Icon(icon, color: Colors.white, size: 28),
//         //SizedBox(width: 12),
//         Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.white,
//             letterSpacing: 2,
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   Widget buildExpandableMenu(String title, Color color, IconData icon, List<Widget> children, {TextStyle? textStyle}) {
//     // final screenWidth = MediaQuery.of(context).size.width;
//     // final screenHeight = MediaQuery.of(context).size.height;
//     // final menuheight = (screenHeight - 28*2) / 5;
//     return Container(
//       color: color,
//       child: ExpansionTile(
//         leading: Icon(icon, color: Colors.white, size: 28),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.white,
//             letterSpacing: 2,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         trailing: SizedBox.shrink(),
//         children: children.map((child) {
//           if (child is ListTile) {
//             return ListTile(
//               title: Text(
//                 (child.title as Text).data!,
//                 style: textStyle ?? TextStyle(color: Colors.white),
//               ),
//             );
//           }
//           return child;
//         }).toList(),

          
        
        
//       )
//     );
//   }

//     @override
//     void didChangeDependencies() {
//       super.didChangeDependencies();

//       // Measure sizes after first frame
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         final topBox = _topBarKey.currentContext?.size;
//         final bottomBox = _bottomBarKey.currentContext?.size;

//         if (mounted) {
//           setState(() {
//             topBarHeight = topBox?.height ?? 0;
//             bottomBarHeight = bottomBox?.height ?? 0;
//           });
//         }
//       });
//     }
//   }
// //   @override
// //   Widget build(BuildContext context) {
// //     // This method is rerun every time setState is called, for instance as done
// //     // by the _incrementCounter method above.
// //     //
// //     // The Flutter framework has been optimized to make rerunning build methods
// //     // fast, so that you can just rebuild anything that needs updating rather
// //     // than having to individually change instances of widgets.
// //     return Scaffold(
// //       appBar: AppBar(
// //         // TRY THIS: Try changing the color here to a specific color (to
// //         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
// //         // change color while the other colors stay the same.
// //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// //         // Here we take the value from the MyHomePage object that was created by
// //         // the App.build method, and use it to set our appbar title.
// //         title: Text(widget.title),
// //       ),
// //       body: Center(
// //         // Center is a layout widget. It takes a single child and positions it
// //         // in the middle of the parent.
// //         child: Column(
// //           // Column is also a layout widget. It takes a list of children and
// //           // arranges them vertically. By default, it sizes itself to fit its
// //           // children horizontally, and tries to be as tall as its parent.
// //           //
// //           // Column has various properties to control how it sizes itself and
// //           // how it positions its children. Here we use mainAxisAlignment to
// //           // center the children vertically; the main axis here is the vertical
// //           // axis because Columns are vertical (the cross axis would be
// //           // horizontal).
// //           //
// //           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
// //           // action in the IDE, or press "p" in the console), to see the
// //           // wireframe for each widget.
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             const Text('You have pushed the button this many times:'),
// //             Text(
// //               '$_counter',
// //               style: Theme.of(context).textTheme.headlineMedium,
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _incrementCounter,
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ), // This trailing comma makes auto-formatting nicer for build methods.
// //     );
// //   }
// // }
