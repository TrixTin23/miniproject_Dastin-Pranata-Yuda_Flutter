import 'package:flutter/material.dart';
import 'package:hungryhub/Login_Register/Service/auth_view_model.dart';
import 'package:hungryhub/Login_Register/View/login_page.dart';
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
              color: Color(0xff272829),
            ),
            child: Text(
              'HungryHub',
              style: TextStyle(
                color: Color(0xffd2e603),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
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
              leading: Icon(Icons.logout_outlined),
              title: const Text('Login'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
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
