import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Service/auth_view_model.dart';
import 'edit_profile_page.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selamat datang, ${authViewModel.currentUser?.username ?? 'Pengguna'}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (authViewModel.isAuthenticated)
              Column(
                children: <Widget>[
                  Text('Username: ${authViewModel.currentUser?.username ?? ''}'),
                  Text('Password: ${authViewModel.currentUser?.password ?? ''}'),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );                
                // Tambahkan logika untuk mengedit profil pengguna
                // Anda dapat menggunakan showDialog atau Navigator.push untuk mengedit data pengguna
              },
              child: Text('Edit Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
