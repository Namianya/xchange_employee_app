import 'package:flutter/material.dart';
import 'package:xchange/views/confirm_password.dart';
import 'package:xchange/views/home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumber = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  ConfirmNumber(
                  phoneNumber: phoneNumber.text,
                ),
              ),
            );
          }),
      appBar: AppBar(
        title: Text(
          'Employee Login',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: phoneNumber,
              decoration: InputDecoration(
                  focusColor: Theme.of(context).primaryColor,
                  border: const OutlineInputBorder(),
                  label: const Text('Phone Number'),
                  icon: const Icon(Icons.phone)),
            ),
          )
        ],
      ),
    );
  }
}
