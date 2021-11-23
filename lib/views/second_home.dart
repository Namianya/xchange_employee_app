import 'package:flutter/material.dart';
import 'package:fare_rate_mm/views/profile.dart';

class SecondHome extends StatefulWidget {
  const SecondHome({Key? key}) : super(key: key);

  @override
  _SecondHomeState createState() => _SecondHomeState();
}

class _SecondHomeState extends State<SecondHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Xchange', style: Theme.of(context).textTheme.headline6),
        // centerTitle: true,
        leading: const Icon(Icons.menu),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            child: const Hero(
              tag: 'avatar',
              child: CircleAvatar(
                child: FlutterLogo(),
                radius: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const Text('data'),
              Form(
                child: Column(
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                        // prefix: Text('From: '),
                        label: Text('From'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
