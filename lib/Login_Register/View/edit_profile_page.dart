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
  String _newUsername = '';
  String _newPassword = '';

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
                decoration: InputDecoration(labelText: 'New Username'),
                onSaved: (value) {
                  _newUsername = value!;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onSaved: (value) {
                  _newPassword = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    authViewModel.editProfile(_newUsername, _newPassword);
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
                        title: Text('Hapus Akun'),
                        content:
                            Text('Apakah Anda yakin ingin menghapus akun?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Batal'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Hapus'),
                            onPressed: () {
                              authViewModel.deleteAccount();
                              Navigator.of(context).pop();
                              // Kembali ke halaman login atau halaman awal aplikasi
                              // Misalnya:
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
                child: Text('Hapus Akun'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
