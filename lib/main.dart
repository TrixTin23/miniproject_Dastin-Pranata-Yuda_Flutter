import 'package:flutter/material.dart';
import 'package:hungryhub/Model/provider/restaurant_manager.dart';
import 'package:hungryhub/View/splash_screen.dart';
import 'package:provider/provider.dart';


void main() => ChangeNotifierProvider(create: (context) => RestaurantProvider(), child: HungryHub());

class HungryHub extends StatelessWidget {
  const HungryHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hungry Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // Buat class untuk menyimpan data atau state aplikasi
// class AppData with ChangeNotifier {
//   bool _isLoading = true; // State untuk menunjukkan apakah aplikasi sedang memuat

//   bool get isLoading => _isLoading; // Getter untuk mengakses state isLoading

//   // Method untuk mengubah state isLoading
//   void setIsLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners(); // Memanggil notifyListeners untuk memberitahu perubahan
//   }
// }

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => AppData(), // Mendaftarkan AppData sebagai provider
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SplashScreen(),
//     );
//   }
// }

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Mendapatkan instance AppData dari provider
//     final appData = Provider.of<AppData>(context);

//     // Delay untuk simulasi pemrosesan data (misalnya, pengambilan data dari API)
//     Future.delayed(Duration(seconds: 3), () {
//       appData.setIsLoading(false); // Setelah selesai, beritahu bahwa loading selesai
//     });

//     return Scaffold(
//       body: Center(
//         child: appData.isLoading
//             ? CircularProgressIndicator() // Tampilkan animasi loading jika isLoading true
//             : Text("Splash Screen Completed"), // Tampilkan pesan jika isLoading false
//       ),
//     );
//   }
// }
