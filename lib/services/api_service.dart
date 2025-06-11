import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quiz.dart';

class ApiService {
  static const String baseUrl = 'http://localhost/quizaja_api';

  Future<Map<String, dynamic>> register(String username, String email, String password) async {
    final client = http.Client();
    final response = await client.post(
      Uri.parse('$baseUrl/register.php'),
      body: json.encode({'username': username, 'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final client = http.Client();
    final response = await client.post(
      Uri.parse('$baseUrl/login.php'),
      body: json.encode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    return json.decode(response.body);
  }

  Future<List<Quiz>> getQuizzes(String category, int limit) async {
    final client = http.Client();
    final response = await client.get(Uri.parse('$baseUrl/get_quizzes.php?category=$category&limit=$limit'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Quiz.fromJson(data)).toList();
    } else {
      throw Exception('Gagal ambil kuis, bro!');
    }
  }

  Future<void> saveScore(int userId, String username, int score, String category) async {
    final client = http.Client();
    final response = await client.post(
      Uri.parse('$baseUrl/save_score.php'),
      body: json.encode({
        'user_id': userId,
        'username': username,
        'score': score,
        'category': category,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menyimpan skor: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    if (data['status'] != 'success') {
      throw Exception(data['message']);
    }
  }

  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    final client = http.Client();
    final response = await client.get(Uri.parse('$baseUrl/get_leaderboard.php'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Gagal ambil leaderboard: ${response.statusCode}');
    }
  }

  // Fungsi baru untuk mengambil data pengguna
  Future<Map<String, dynamic>> getUserData(int userId) async {
    final client = http.Client();
    final response = await client.get(
      Uri.parse('$baseUrl/profile.php?action=get&user_id=$userId'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return data['data'];
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Gagal mengambil data pengguna: ${response.statusCode}');
    }
  }

  // Fungsi baru untuk update profil
  Future<void> updateProfile(int userId, String username, String email, String? password) async {
    final client = http.Client();
    final body = {
      'user_id': userId.toString(),
      'username': username,
      'email': email,
      'password': password,
    };
    final response = await client.post(
      Uri.parse('$baseUrl/profile.php?action=update'),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal update profil: ${response.statusCode}');
    }
    final data = jsonDecode(response.body);
    if (data['status'] != 'success') {
      throw Exception(data['message']);
    }
  }

  // Fungsi baru untuk hapus akun
  Future<void> deleteAccount(int userId) async {
    final client = http.Client();
    final response = await client.post(
      Uri.parse('$baseUrl/profile.php?action=delete'),
      body: jsonEncode({'user_id': userId}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus akun: ${response.statusCode}');
    }
    final data = jsonDecode(response.body);
    if (data['status'] != 'success') {
      throw Exception(data['message']);
    }
  }
}