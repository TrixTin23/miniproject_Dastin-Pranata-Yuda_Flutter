import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Service/auth_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    TextEditingController emailController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    // Wrap this Center around the Image
                    child: Image.asset(
                      "assets/images/Hungry-hub.png",
                      height: 300,
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        hintText: "Enter Your full name",
                        labelText: 'Full name',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your full name' : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                        hintText: "Enter Your Phone Number",
                        labelText: 'Phone Number',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your phone number'
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Enter Your Username",
                        labelText: 'Email',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your email' : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Enter Your Password",
                        labelText: 'Password',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your password' : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String fullName = fullNameController.text;
                        String phoneNumber = phoneNumberController.text;
                        String email = emailController.text;
                        String password = passwordController.text;
                        authViewModel.register(
                            fullName, phoneNumber, email, password);
                        Navigator.pop(context); // Kembali ke layar login
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(300),
                      primary: const Color(
                          0xfff1c376), // Warna latar belakang tombol
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
      ),
      backgroundColor: const Color(0xfffff4f4), // Warna latar belakang halaman
    );
  }
}
