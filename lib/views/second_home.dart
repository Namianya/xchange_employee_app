// import 'package:fare_rate_mm/views/profile.dart';
// import 'package:flutter/material.dart';

// class SecondHome extends StatelessWidget {
//   const SecondHome({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(Icons.menu),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ProfilePage(),
//                 ),
//               );
//             },
//             child: const Hero(
//               tag: 'avatar',
//               child: CircleAvatar(
//                 child: FlutterLogo(),
//                 radius: 20,
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 15,
//           ),

//         ],
//       ),
//       body:  Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'KSH',
//               style: TextStyle(fontSize: 20),
//             ),
//             DropdownButtonFormField(items: items, onChanged: (String newvalue) {
//               value = newvalue;
//             }),
//             }),
//           ]),
//       ),
//     );
//   }
// }