import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xchange/services/data_store.dart';
import 'package:xchange/services/rate.dart';

class BuyingRatesView extends StatelessWidget {
  const BuyingRatesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store storage = Store();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Buying Rates',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: StreamProvider<List<Rate>>.value(
          initialData: [],
          value: storage.rate,
          child: _RateTileContent(),
        ));
  }
}

class _RateTileContent extends StatelessWidget {
  const _RateTileContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rate = Provider.of<List<Rate>>(context);
    rate.forEach((rate) {
      print(rate.ksh);
    });
    return Container();
  }
}
