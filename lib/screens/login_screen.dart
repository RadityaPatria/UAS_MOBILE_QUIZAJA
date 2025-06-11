import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../providers/quiz_provider.dart';
import '../services/api_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await _apiService.login(
        _usernameController.text,
        _passwordController.text,
      );
      print("Login response: $result");
      if (result['status'] == 'success') {
        final quizProvider = Provider.of<QuizProvider>(context, listen: false);
        // Pastikan response memiliki user_id
        final userId = result['data']['user_id'] ?? result['user_id'];
        if (userId == null) {
          throw Exception('user_id tidak ditemukan di response');
        }
        quizProvider.setUserId(int.parse(userId.toString())); // Konversi ke int
        quizProvider.setUsername(_usernameController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'])),
        );
      }
    } catch (e) {
      print("Error during login: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth > 600 ? 32.0 : 12.0;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey[50]!,
              Colors.teal[100]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: SingleChildScrollView(
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.teal[200]!, width: 1),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.quiz,
                                size: 60,
                                color: Colors.teal,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Selamat Datang di Quizaja!',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth > 600 ? 28 : 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person, color: Colors.teal),
                                  labelText: 'Username',
                                  labelStyle: GoogleFonts.poppins(
                                    color: Colors.blueGrey[600],
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  color: Colors.blueGrey[800],
                                  fontSize: screenWidth > 600 ? 16 : 14,
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock, color: Colors.teal),
                                  labelText: 'Password',
                                  labelStyle: GoogleFonts.poppins(
                                    color: Colors.blueGrey[600],
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                obscureText: true,
                                style: GoogleFonts.poppins(
                                  color: Colors.blueGrey[800],
                                  fontSize: screenWidth > 600 ? 16 : 14,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _isLoading
                                  ? const SpinKitCircle(
                                      color: Colors.teal,
                                      size: 40.0,
                                    )
                                  : FadeInUp(
                                      duration: const Duration(milliseconds: 800),
                                      child: ElevatedButton(
                                        onPressed: _login,
                                        child: Text(
                                          'Masuk, Yuk!',
                                          style: GoogleFonts.poppins(
                                            fontSize: screenWidth > 600 ? 20 : 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                                  );
                                },
                                child: Text(
                                  'Belum punya akun? Daftar sini!',
                                  style: GoogleFonts.poppins(
                                    color: Colors.teal[600],
                                    fontSize: screenWidth > 600 ? 16 : 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}