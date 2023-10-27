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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/Hungry-hub.png",
                height: 350,
                width: 350,
              ),
              const Text(
                'Buat Akun Baru',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff606c5d)), // Warna teks
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: UnderlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String username = usernameController.text;
                  String password = passwordController.text;
                  authViewModel.register(username, password);
                  Navigator.of(context).pop(); // Kembali ke layar login
                },
                child: const Text(
                  'Daftar',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(200),
                  primary:
                      const Color(0xfff1c376), // Warna latar belakang tombol
                  onPrimary: const Color(0xff606c5d), // Warna teks tombol
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
                      fontSize: 16,
                      color: Color(0xff606c5d)), // Warna teks tombol
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xfffff4f4), // Warna latar belakang halaman
    );
  }
}
