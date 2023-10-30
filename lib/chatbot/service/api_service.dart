import '../model/api_key.dart';
import 'package:dio/dio.dart';

class APIService {
  Future<String> getAIResponse(String message) async {
    final dio = Dio();

    final Map<String, dynamic> requestData = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "system", "content": "Kamu hanya akan memberikan hasil rekomendasi restorant, jika $message tidak meminta rekomendasi maka hasil yang diberikan adalah pertanyaan untuk validasi rekomendasi restorant"},
        {"role": "user", "content": message}
      ]
    };

    try {
      final response = await dio.post(
        'https://api.openai.com/v1/chat/completions',
        data: requestData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      throw Exception('Failed to load response: $e');
    }
  }
}
