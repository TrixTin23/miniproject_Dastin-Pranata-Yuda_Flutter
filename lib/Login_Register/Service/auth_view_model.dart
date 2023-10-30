import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/model.dart';

class AuthViewModel with ChangeNotifier {
  bool isAuthenticated = false;
  List<ModelUser> registeredUsers = [];
  ModelUser? currentUser;

  AuthViewModel() {
    // Cek apakah ada pengguna yang sudah terotentikasi
    checkAuthentication();
  }

  Future<void> login(String email, String password) async {
    // Mencari pengguna dengan username dan password yang sesuai
    final user = registeredUsers.firstWhere(
        (user) => user.email == email && user.password == password,
      orElse: () => ModelUser(fullName: '', phoneNumber: '', email: '', password: ''),
);

    if (user.fullName.isNotEmpty) {
      isAuthenticated = true;
      currentUser = user;
      notifyListeners();
    }
  }

  Future<void> register(String fullName, String phoneNumber, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the user is already registered
    final isUserAlreadyRegistered = registeredUsers.any((user) => user.email == email);

    if (isUserAlreadyRegistered) {
      // Show a message or dialog indicating that the user is already registered
      SnackBar(content: Text("User already registered"));
    } else {
      // Add the new user to the list of registered users if not registered
      registeredUsers.add(ModelUser(fullName: fullName, phoneNumber: phoneNumber, email: email, password: password));

      // Save the list of registered users to SharedPreferences
      await prefs.setStringList(
        'registeredUsers',
        registeredUsers
            .map((user) => '${user.fullName}:${user.phoneNumber}:${user.email}:${user.password}')
            .toList(),
      );
    }
  }


  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    isAuthenticated = false;
    currentUser = null;
    notifyListeners();
  }

  Future<void> editProfile(String fullName, String newEmail, String newPassword, String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();

    if (isAuthenticated && currentUser != null) {
      // Find the index of the currently logged-in user in the list of registered users
      final userIndex = registeredUsers.indexWhere((user) => user.email == currentUser!.email);

      if (userIndex != -1) {
        // Update the email and password of the currently logged-in user
        registeredUsers[userIndex] = ModelUser(fullName: fullName, phoneNumber: phoneNumber, email: newEmail, password: newPassword);

        // Save the changes to SharedPreferences
        await prefs.setStringList(
          'registeredUsers',
          registeredUsers
              .map((user) => '${user.fullName}:${user.phoneNumber}:${user.email}:${user.password}')
              .toList(),
        );

        // Update currentUser with the new data
        currentUser = ModelUser(fullName: fullName, phoneNumber: phoneNumber, email: newEmail, password: newPassword);
      }
    }

    notifyListeners();
  }

  Future<void> deleteAccount() async {
    if (isAuthenticated && currentUser != null) {
      final prefs = await SharedPreferences.getInstance();

      // Remove the currently logged-in user from the list of registered users
      registeredUsers.removeWhere((user) => user.email == currentUser!.email);

      // Save the updated list of registered users to SharedPreferences
      await prefs.setStringList(
        'registeredUsers',
        registeredUsers
            .map((user) => '${user.fullName}:${user.phoneNumber}:${user.email}:${user.password}')
            .toList(),
      );

      // Remove authentication information
      await prefs.remove('isAuthenticated');
      await prefs.remove('lastLoggedInUser');

      // Reset authentication status and currentUser
      isAuthenticated = false;
      currentUser = null;

      notifyListeners();
    }
  }

  Future<void> checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final isUserAuthenticated = prefs.getBool('isAuthenticated') ?? false;

    if (isUserAuthenticated) {
      isAuthenticated = true;

      // Get the list of registered users from SharedPreferences
      final registeredUsersData = prefs.getStringList('registeredUsers') ?? [];

      // Convert user data to User objects
      registeredUsers = registeredUsersData.map((data) {
        final parts = data.split(':');
        return ModelUser(fullName: parts[0], phoneNumber: parts[1], email: parts[2], password: parts[3]);
      }).toList();

      // Show the last logged-in user
      final lastLoggedInUser = prefs.getString('lastLoggedInUser');
      if (lastLoggedInUser != null) {
        final user = registeredUsers.firstWhere(
          (user) => user.email == lastLoggedInUser,
          orElse: () => ModelUser(fullName: '', phoneNumber: '', email: '', password: ''),
        );
        if (user.fullName.isNotEmpty) {
          currentUser = user;
        }
      }
    }
    notifyListeners();
  }
}

