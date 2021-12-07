import 'package:fare_rate_mm/services/data_store.dart';
import 'package:fare_rate_mm/services/riverpod_providers.dart';
import 'package:fare_rate_mm/services/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    String? num = FirebaseAuth.instance.currentUser!.phoneNumber;
    final currentUser = ref.watch(currentUserData);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: currentUser.when(
          data: (data) => Column(
            children: [
              Hero(
                  tag: 'avatar',
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                    radius: MediaQuery.of(context).size.width * 0.2,
                  )),
              const SizedBox(
                height: 30,
              ),
              _userTextInfo(
                context,
                data.phoneNumber,
                'Phone Number',
              ),
              _userTextInfo(
                context,
                data.name,
                'Name',
              ),
            ],
          ),
          error: (e, s) => Text('$e'),
          loading: () => Center(child: const CircularProgressIndicator()),
        ),
      ),
    );
  }

  RichText _userTextInfo(BuildContext context, dynamic data, String title) {
    return RichText(
      text: TextSpan(
        text: title + ': ',
        style: Theme.of(context).textTheme.bodyText1,
        children: [
          TextSpan(
            text: '  ${data}',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
