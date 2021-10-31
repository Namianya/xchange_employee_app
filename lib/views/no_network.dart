import 'package:flutter/material.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.wifi_off,
              color: Colors.grey,
              size: MediaQuery.of(context).size.width * 0.35,
            ),
            Text(
              'Network Error',
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
