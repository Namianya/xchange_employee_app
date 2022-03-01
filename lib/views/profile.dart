import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final _currentUser = ref.watch(currentUserData);
    final _stockModel = ref.watch(stockStream);
    var f = NumberFormat("#,###,###,###.0#", "en_US");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: _currentUser.when(
          data: (data) => Column(
            children: [
              Hero(
                  tag: 'avatar',
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 100,
                  )),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Shop:'),
                  SizedBox(
                    width: 20,
                  ),
                  Flag.fromString(
                    data.kenyaShop! ? 'KE' : 'UG',
                    height: 20,
                    width: 30,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              _infoTile(size: size, data: data.userName, context: context),
              const SizedBox(
                height: 10,
              ),
              _infoTile(size: size, data: data.phoneNumber, context: context),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                height: 10,
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
                          'KSH: ${f.format(d.ksh)}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'USH: ${f.format(d.ush)}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'USD: ${f.format(d.usd)}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                  Navigator.pop(context);
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
