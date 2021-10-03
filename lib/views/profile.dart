import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              backgroundColor: Theme.of(context).primaryColor,
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
            'Name',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Employee Name',
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
          )
        ],
      ),
    );
  }
}
