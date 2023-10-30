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
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _newFullNameController = TextEditingController();
  TextEditingController _newPhoneNumberController = TextEditingController();
  TextEditingController _newUserEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
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
                decoration: InputDecoration(labelText: 'New Full Name'),
              ),
              TextFormField(
                controller: _newPhoneNumberController,
                decoration: InputDecoration(labelText: 'New Phone Number'),
              ),
              TextFormField(
                controller: _newUserEmailController,
                decoration: InputDecoration(labelText: 'New Email'),
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              ElevatedButton(
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
                child: Text('Save Profile'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Account'),
                        content: Text(
                            'Are you sure you want to delete your account?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
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
                child: Text('Delete Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
