import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentUser = ref.watch(currentUserData);
    final _stockModel = ref.watch(stockStream);
    final _currentStockStreamProvider = ref.watch(currentStockStreamProvider);

    var f = NumberFormat("#,###,###,###.0#", "en_US");
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: theme.textTheme.headline5,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: _currentUser.when(
        data: (data) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Hero(
                  tag: 'avatar',
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: const RiveAnimation.asset(
                      'assets/anime/avater.riv',
                      artboard: 'Avatar 1',
                      animations: ['Animation 1'],
                    ),
                    radius: 50,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'User Details'.toUpperCase(),
                  style: theme.textTheme.headline5!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'User Name'.toUpperCase(),
                style: theme.textTheme.bodyText1!.copyWith(
                  color: Colors.indigo[400],
                  letterSpacing: 1,
                ),
              ),
              Text(
                data.userName.toUpperCase(),
                style: theme.textTheme.headline6!.copyWith(
                  color: Colors.black,
                  letterSpacing: 3.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Phone Number'.toUpperCase(),
                style: theme.textTheme.bodyText1!.copyWith(
                  color: Colors.indigo[400],
                  letterSpacing: 1,
                ),
              ),
              Text(
                data.phoneNumber.toUpperCase(),
                style: theme.textTheme.headline6!.copyWith(
                  color: Colors.black,
                  letterSpacing: 3.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Station/ Shop'.toUpperCase(),
                style: theme.textTheme.bodyText1!.copyWith(
                  color: Colors.indigo[400],
                  letterSpacing: 1,
                ),
              ),
              Text(
                (data.kenyaShop! ? 'Kenya' : 'Uganda').toUpperCase(),
                style: theme.textTheme.headline6!.copyWith(
                  color: Colors.black,
                  letterSpacing: 3.0,
                ),
              ),
              Flag.fromString(
                data.kenyaShop! ? 'KE' : 'UG',
                height: 20,
                width: 30,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Stock'.toUpperCase(),
                  style: theme.textTheme.headline5!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _stockModel.when(
                data: (d) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assigned Stock on'.toUpperCase() +
                          ': ' +
                          DateFormat.yMd()
                              .add_jm()
                              .format(d.createdOn.toDate()),
                      style: theme.textTheme.bodyText1!.copyWith(
                        color: Colors.indigo[400],
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'KSH: ${f.format(d.ksh)}',
                      style: theme.textTheme.headline6!.copyWith(
                        color: Colors.green,
                        letterSpacing: 3.0,
                      ),
                    ),
                    Text(
                      'USH: ${f.format(d.ush)}',
                      style: theme.textTheme.headline6!.copyWith(
                        color: Colors.orange,
                        letterSpacing: 3.0,
                      ),
                    ),
                    Text(
                      'USD: ${f.format(d.usd)}',
                      style: theme.textTheme.headline6!.copyWith(
                        color: Colors.indigo,
                        letterSpacing: 3.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                error: (e, s) => Text('$e'),
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              _currentStockStreamProvider.when(
                data: (d) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Stock'.toUpperCase() +
                          ': ' +
                          DateFormat.yMd()
                              .add_jm()
                              .format(d.createdOn.toDate()),
                      style: theme.textTheme.bodyText1!.copyWith(
                        color: Colors.indigo[400],
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'KSH: ${f.format(d.ksh)}',
                      style: theme.textTheme.headline6!.copyWith(
                        color: Colors.green,
                        letterSpacing: 3.0,
                      ),
                    ),
                    Text(
                      'USH: ${f.format(d.ush)}',
                      style: theme.textTheme.headline6!.copyWith(
                        color: Colors.orange,
                        letterSpacing: 3.0,
                      ),
                    ),
                    Text(
                      'USD: ${f.format(d.usd)}',
                      style: theme.textTheme.headline6!.copyWith(
                        color: Colors.indigo,
                        letterSpacing: 3.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                error: (e, s) => Text('$e'),
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
        error: (e, s) => Text('$e'),
        loading: () => Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
