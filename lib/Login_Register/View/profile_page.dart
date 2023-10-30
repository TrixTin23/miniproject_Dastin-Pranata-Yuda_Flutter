import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Service/auth_view_model.dart';
import 'edit_profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.network(
                      'https://picsum.photos/200',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Welcome, ${authViewModel.currentUser?.fullName ?? 'User'}!',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (authViewModel.isAuthenticated)
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          initialValue: authViewModel.currentUser?.email ?? '',
                          enabled: false, // Disable editing
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          initialValue:
                              authViewModel.currentUser?.phoneNumber ?? '',
                          enabled: false, // Disable editing
                          decoration:
                              const InputDecoration(labelText: 'Phone Number'),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          initialValue:
                              authViewModel.currentUser?.password ?? '',
                          obscureText: !_showPassword,
                          enabled: false, // Disable editing
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const Text('Show Password'),
                            Checkbox(
                              value: _showPassword,
                              onChanged: (value) {
                                setState(() {
                                  _showPassword = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(),
                      ),
                    );
                  },
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
