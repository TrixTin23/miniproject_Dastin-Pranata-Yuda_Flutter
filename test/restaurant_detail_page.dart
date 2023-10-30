import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hungryhub/restaurant_list/View/restaurant_detail.dart';

void main() {
  testWidgets('Test RestaurantDetailPage UI', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RestaurantDetailPage(id: 'restaurant_id'), // Ganti 'restaurant_id' dengan ID restoran yang sesuai
    ));

    // Tunggu hingga data dimuat
    await tester.pumpAndSettle();

    // Mengecek apakah teks "Restaurant Detail" muncul di app bar
    expect(find.text('Restaurant Detail'), findsOneWidget);

    // Mengecek apakah gambar restoran muncul
    expect(find.byType(Image), findsOneWidget);

    // Mengecek apakah nama restoran muncul
    expect(find.text('Restaurant Name'), findsOneWidget); // Ganti dengan nama restoran yang sesuai

    // Mengecek apakah alamat restoran muncul
    expect(find.text('Restaurant Address'), findsOneWidget); // Ganti dengan alamat restoran yang sesuai

    // Mengecek apakah ulasan pelanggan muncul
    expect(find.text('Customer Reviews'), findsOneWidget);

    // Mengecek apakah tombol "Add Comment" muncul
    expect(find.byIcon(Icons.add_comment), findsOneWidget);

    // Mengecek apakah bintang rating muncul
    expect(find.byIcon(Icons.star), findsNWidgets(5)); // Jika Anda memiliki bintang 5, jika tidak sesuaikan dengan jumlah bintangnya

    // Mengecek apakah daftar kategori muncul
    expect(find.byType(Chip), findsNWidgets(3)); // Ganti 3 dengan jumlah kategori yang sesuai

    // Mengecek apakah daftar menu muncul
    expect(find.byType(Text), findsNWidgets(6)); // Ganti 6 dengan jumlah menu yang sesuai

    // Mengecek apakah daftar ulasan pelanggan muncul
    expect(find.byType(Card), findsWidgets); // Pastikan ada ulasan pelanggan yang tampil

    // Melakukan scroll ke atas dan bawah untuk memeriksa elemen lainnya
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, 300));
    await tester.pumpAndSettle();
  });
}
