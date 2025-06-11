import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../providers/quiz_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final userId = quizProvider.userId;
    if (userId == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return;
    }
    _fetchUserData(userId);
  }

  Future<void> _fetchUserData(int userId) async {
    try {
      final userData = await _apiService.getUserData(userId);
      setState(() {
        _usernameController.text = userData['username'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal memuat data: $e')));
    }
  }

  Future<void> updateProfile(int userId) async {
    try {
      await _apiService.updateProfile(
        userId,
        _usernameController.text,
        _emailController.text,
        _passwordController.text.isNotEmpty ? _passwordController.text : null,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profil berhasil diperbarui')));
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      quizProvider.setUsername(_usernameController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
    }
  }

  Future<void> deleteAccount(int userId) async {
    try {
      await _apiService.deleteAccount(userId);
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menghapus: $e')));
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth > 600 ? 32.0 : 16.0;
    final quizProvider = Provider.of<QuizProvider>(context);

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
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.teal))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start, // Header di atas
                    children: [
                      FadeInDown(
                        duration: const Duration(milliseconds: 800),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.teal,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Text(
                              'Profil Pengguna',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth > 600 ? 36 : 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800],
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                      ),
                      Expanded( // Menggunakan Expanded untuk mengisi sisa ruang
                        child: Center( // Menempatkan form di tengah sisa ruang
                          child: SingleChildScrollView(
                            child: FadeInDown(
                              duration: const Duration(milliseconds: 800),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Edit Profil Anda',
                                      style: GoogleFonts.poppins(
                                        fontSize: screenWidth > 600 ? 20 : 18,
                                        color: Colors.blueGrey[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        labelText: 'Username',
                                        labelStyle: GoogleFonts.poppins(
                                          color: Colors.blueGrey[700],
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.teal[200]!),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: GoogleFonts.poppins(color: Colors.blueGrey[800]),
                                    ),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: GoogleFonts.poppins(
                                          color: Colors.blueGrey[700],
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.teal[200]!),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: GoogleFonts.poppins(color: Colors.blueGrey[800]),
                                    ),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Password Baru (opsional)',
                                        labelStyle: GoogleFonts.poppins(
                                          color: Colors.blueGrey[700],
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.teal[200]!),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      obscureText: true,
                                      style: GoogleFonts.poppins(color: Colors.blueGrey[800]),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await updateProfile(quizProvider.userId);
                                      },
                                      child: Text(
                                        'Simpan Perubahan',
                                        style: GoogleFonts.poppins(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        bool confirm = await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Hapus Akun', style: GoogleFonts.poppins()),
                                            content: Text(
                                              'Apakah Anda yakin ingin menghapus akun?',
                                              style: GoogleFonts.poppins(),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, false),
                                                child: Text('Tidak', style: GoogleFonts.poppins()),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, true),
                                                child: Text('Ya', style: GoogleFonts.poppins()),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (confirm == true) {
                                          await deleteAccount(quizProvider.userId);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                      child: Text(
                                        'Hapus Akun',
                                        style: GoogleFonts.poppins(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}