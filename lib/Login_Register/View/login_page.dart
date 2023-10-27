import 'package:flutter/material.dart';
import 'package:hungryhub/View/restaurant_list.dart';
import 'package:provider/provider.dart';

import '../Service/auth_view_model.dart';
import 'register_page.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    String username = '';
    String password = '';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/Hungry-hub.png",
                height: 350,
                width: 350,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  onChanged: (value) {
                    username = value;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: "Enter Your Password",
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await authViewModel.login(username, password);

                  if (authViewModel.isAuthenticated) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RestaurantListPage(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text("Login gagal. Periksa username dan password."),
                      ),
                    );
                  }
                },
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(200),
                  primary: Color(0xfff1c376),
                  onPrimary: Color(0xff606c5d),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text('Register'),
                style: TextButton.styleFrom(
                  primary: Color(0xff606c5d),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xffFFF4F4),
    );
  }
}
