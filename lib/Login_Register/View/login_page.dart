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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              // Change Center to Column
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  // Wrap this Center around the Image
                  child: Image.asset(
                    "assets/images/Hungry-hub.png",
                    height: 350,
                    width: 350,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: "Enter Your Username",
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
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
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
                        const SnackBar(
                          content: Text(
                              "Login gagal. Periksa username dan password."),
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(300),
                    primary: const Color(0xfff1c376),
                    onPrimary: const Color(0xff606c5d),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text('Daftar disini!'),
                      style: TextButton.styleFrom(
                        primary: const Color(0xff606c5d),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xffFFF4F4),
    );
  }
}
