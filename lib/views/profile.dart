import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            child: Hero(
              tag: 'avatar',
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: size.width * 0.37,
              ),
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
            style: Theme.of(context).textTheme.bodyText1,
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
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
