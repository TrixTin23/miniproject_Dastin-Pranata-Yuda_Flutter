import 'package:flutter/material.dart';
import 'package:hungryhub/Login_Register/View/login_page.dart';
import 'package:provider/provider.dart';

import '../Service/auth_view_model.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newFullNameController = TextEditingController();
  final TextEditingController _newPhoneNumberController =
      TextEditingController();
  final TextEditingController _newUserEmailController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _newFullNameController,
                decoration: const InputDecoration(labelText: 'New Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _newPhoneNumberController,
                decoration:
                    const InputDecoration(labelText: 'New Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _newUserEmailController,
                decoration: const InputDecoration(labelText: 'New Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: !_showPassword, // Perubahan di sini
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(_showPassword
                        ? Icons.visibility
                        : Icons.visibility_off), // Perubahan di sini
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Menggunakan "mainAxisAlignment" bukan "MainAxisAlignment"
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          authViewModel.editProfile(
                            _newFullNameController.text,
                            _newUserEmailController.text,
                            _newPhoneNumberController.text,
                            _newPasswordController.text,
                          );
                          Navigator.pop(context); // Kembali ke halaman profil
                        }
                      },
                      child: const Text('Save Profile'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete Account'),
                              content: const Text(
                                  'Are you sure you want to delete your account?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    authViewModel.deleteAccount();
                                    Navigator.of(context).pop();
                                    // Navigate to the login screen or the app's home screen
                                    // For example:
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Delete Account'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
