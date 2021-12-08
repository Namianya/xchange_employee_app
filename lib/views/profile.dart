import 'package:fare_rate_mm/services/data_store.dart';
import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/models/user_model.dart';
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
    final _stockModel = ref.watch(stockStream);
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
              _infoTile(size: size, data: data.name, context: context),
              const SizedBox(
                height: 10,
              ),
              _infoTile(size: size, data: data.phoneNumber, context: context),
              const SizedBox(
                height: 40,
              ),
              Text(
                'My Assigned Stock',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 10,
              ),
              _stockModel.when(
                data: (d) => Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'KSH: ${d.ksh}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'USH: ${d.ush}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'USD: ${d.usd}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    Text(
                      'Assigned On: ${d.createdOn.toDate()}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                error: (e, s) => Text('$e'),
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                icon: Icon(Icons.logout),
                label: Text('Log Out'),
              ),
            ],
          ),
          error: (e, s) => Text('$e'),
          loading: () => Center(child: const CircularProgressIndicator()),
        ),
      ),
    );
  }

  Container _infoTile(
      {required Size size,
      required String data,
      required BuildContext context}) {
    return Container(
      width: size.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.indigo[50],
      ),
      child: Center(
        child: Text(
          data.toUpperCase(),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
