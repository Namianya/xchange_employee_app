import 'package:flutter/material.dart';

class UserNotActivated extends StatelessWidget {
  const UserNotActivated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_user_outlined,
              color: Colors.red,
              size: MediaQuery.of(context).size.width * 0.35,
            ),
            Text(
              'User not Activated',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.red,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
