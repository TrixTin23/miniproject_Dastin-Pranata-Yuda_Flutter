import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Service/auth_view_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
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
                const Text(
                  'Buat Akun Baru',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff606c5d)), // Warna teks
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Username",
                      labelText: 'Username',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Password",
                      labelText: 'Password',
                      border: UnderlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    authViewModel.register(username, password);
                    Navigator.of(context).pop(); // Kembali ke layar login
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(300),
                    primary:
                        const Color(0xfff1c376), // Warna latar belakang tombol
                    onPrimary: const Color(0xff606c5d), // Warna teks tombol
                  ),
                  child: const Text(
                    'Daftar',
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Kembali ke layar login
                  },
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                        color: Color(0xff606c5d)), // Warna teks tombol
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xfffff4f4), // Warna latar belakang halaman
    );
  }
}
