// import 'package:advanced_todo/components/bottom_navbar.dart';
// import 'package:advanced_todo/components/overview.dart';
// import 'package:advanced_todo/components/task_tile.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('DailyDone'),
//       ),
//       bottomNavigationBar: BottomNavbar(),
//       body: Column(
//         children: [
//           Overview(),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Today\'s Tasks',
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.inversePrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 //Tasks list area
//                 SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: 5,
//                     physics: ScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return const TaskTile(
//                         name: 'Task',
//                         startTime: '10:00',
//                         endTime: '11:00',
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:advanced_todo/components/bottom_navbar.dart';
import 'package:advanced_todo/components/overview.dart';
import 'package:advanced_todo/components/task_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyDone'),
      ),
      bottomNavigationBar: BottomNavbar(),
      body: Column(
        children: [
          Overview(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Today\'s Tasks',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 30,
              itemBuilder: (context, index) {
                return const TaskTile(
                  name: 'Task',
                  startTime: '10:00',
                  endTime: '11:00',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
