import 'package:flutter/material.dart';

import '../../../core/strings_constants.dart';
import '../../../home/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  "assets/images/tech_logo.png",
                ),
              ),
              ElevatedButton(
                onPressed: _goToListPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    48.0,
                  ),
                ),
                child: const Text(
                  StringsConstants.loginEnterButtonLabel,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToListPage() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  }
}
