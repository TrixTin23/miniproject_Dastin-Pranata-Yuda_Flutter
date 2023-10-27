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

  Future<void> login(String username, String password) async {
    // Mencari pengguna dengan username dan password yang sesuai
    final user = registeredUsers.firstWhere(
        (user) => user.username == username && user.password == password,
        orElse: () => ModelUser(username: '', password: ''));

    if (user.username.isNotEmpty) {
      isAuthenticated = true;
      currentUser = user;
      notifyListeners();
    }
  }

  Future<void> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final isUserAlreadyRegistered =
        registeredUsers.any((user) => user.username == username);

    // Pemeriksaan apakah pengguna sudah terdaftar sebelumnya
    if (isUserAlreadyRegistered) {
      // Tampilkan pesan atau dialog bahwa pengguna sudah terdaftar
      SnackBar(content: Text("data sudah terdaftar"));
    } else {
      // Tambahkan pengguna baru ke daftar pengguna terdaftar jika belum terdaftar
      registeredUsers.add(ModelUser(username: username, password: password));

      // Simpan daftar pengguna terdaftar ke SharedPreferences
      await prefs.setStringList(
          'registeredUsers',
          registeredUsers
              .map((user) => '${user.username}:${user.password}')
              .toList());
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    isAuthenticated = false;
    currentUser = null;
    notifyListeners();
  }

  Future<void> checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final isUserAuthenticated = prefs.getBool('isAuthenticated') ?? false;

    if (isUserAuthenticated) {
      // Jika pengguna sudah terotentikasi, set isAuthenticated menjadi true
      isAuthenticated = true;

      // Ambil daftar pengguna terdaftar dari SharedPreferences
      final registeredUsersData = prefs.getStringList('registeredUsers') ?? [];

      // Konversi data pengguna ke objek ModelUser
      registeredUsers = registeredUsersData.map((data) {
        final parts = data.split(':');
        return ModelUser(username: parts[0], password: parts[1]);
      }).toList();

      // Tampilkan pengguna yang terakhir masuk
      final lastLoggedInUser = prefs.getString('lastLoggedInUser');
      if (lastLoggedInUser != null) {
        final user = registeredUsers.firstWhere(
            (user) => user.username == lastLoggedInUser,
            orElse: () => ModelUser(username: '', password: ''));
        if (user.username.isNotEmpty) {
          currentUser = user;
        }
      }
    }
    notifyListeners();
  }
}
