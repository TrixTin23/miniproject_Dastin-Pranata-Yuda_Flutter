import 'package:flutter/material.dart';
import 'package:hungryhub/Login_Register/Service/auth_view_model.dart';
import 'package:hungryhub/Login_Register/View/login_page.dart';
import 'package:hungryhub/Login_Register/View/profile_page.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff606c5d),
            ),
            child: Text(
              'HungryHub',
              style: TextStyle(
                color: Color(0xfff1c376),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          if (authViewModel.isAuthenticated)
            ListTile(
              leading: Icon(Icons.person_2_outlined),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
          if (authViewModel.isAuthenticated)
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () {
                authViewModel
                    .logout(); // Panggil fungsi logout dari AuthViewModel
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen())); // Tutup drawer
              },
            ),
          if (!authViewModel.isAuthenticated)
            ListTile(
              title: const Text('Register'),
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
        ],
      ),
    );
  }
}
