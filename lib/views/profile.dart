import 'package:fare_rate_mm/services/data_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? num = FirebaseAuth.instance.currentUser!.phoneNumber;
    var currentUserModel = context.watch<Store>().currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Hero(
            tag: 'avatar',
            child: CircleAvatar(
              backgroundColor: Colors.grey[100],
              child: const FlutterLogo(
                size: 100,
              ),
              radius: size.width * 0.3,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Divider(),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Number',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '$num',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Level',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Employee',
            style: Theme.of(context).textTheme.headline5,
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.logout),
            label: Text('Logout'),
          ),
        ],

      ),
    );
  }
}
