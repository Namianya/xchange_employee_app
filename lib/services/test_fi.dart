// import 'package:flutter/material.dart';

// class TestFi extends StatefulWidget {
//   const TestFi({Key? key}) : super(key: key);

//   @override
//   _TestFiState createState() => _TestFiState();
// }

// class _TestFiState extends State<TestFi> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.hasError) {
//           return const Center(
//             child: Text('Somting went wrong'),
//           );
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         final data = snapshot.requireData;
//         return Builder(builder: (context));
//       },
//     );
//   }
// }
