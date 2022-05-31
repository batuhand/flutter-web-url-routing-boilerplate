import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:webroutingtest/main.dart';
import 'package:webroutingtest/model/login_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _textController;
  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "e-mail",
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.email,
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "password",
                prefixIcon: IconButton(
                  onPressed: () async {},
                  icon: const Icon(
                    Icons.lock,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context
                    .read<LoginData>()
                    .saveEmailToSharedPref(_textController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyDataPage()));
              },
              child: const Text("GO"),
            ),
          ],
        ),
      )),
    );
  }
}
