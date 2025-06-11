import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/quiz_provider.dart';
import 'quiz_screen.dart';
import 'login_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Musik', 'icon': Icons.music_note, 'color': Colors.teal},
    {'name': 'Film', 'icon': Icons.movie, 'color': Colors.blueGrey},
    {'name': 'Game', 'icon': Icons.videogame_asset, 'color': Colors.green},
    {'name': 'Pengetahuan Umum', 'icon': Icons.lightbulb, 'color': Colors.yellow[800]},
    {'name': 'Matematika', 'icon': Icons.calculate, 'color': Colors.purple},
    {'name': 'Sains', 'icon': Icons.science, 'color': Colors.orange},
    {'name': 'Seni dan Budaya', 'icon': Icons.palette, 'color': Colors.brown},
    {'name': 'Geografi', 'icon': Icons.map, 'color': Colors.blue}, // Kategori baru
  ];

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          Provider.of<QuizProvider>(context, listen: false).resetQuiz();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.quiz,
                            size: 40,
                            color: Colors.teal,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Quizaja',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth > 600 ? 36 : 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[800],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.leaderboard,
                              color: Colors.teal,
                              size: 28,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                              );
                            },
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            icon: const Icon(
                              Icons.person,
                              color: Colors.teal,
                              size: 28,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                    child: Text(
                      'Halo, ${quizProvider.username}! Pilih kategori kuis favoritmu!',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth > 600 ? 20 : 18,
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenWidth > 600 ? 3 : 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: screenWidth > 600 ? 1.3 : 1.2,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return FadeInUp(
                          duration: Duration(milliseconds: 400 + (index * 100)),
                          child: ZoomIn(
                            duration: const Duration(milliseconds: 200),
                            from: 0.95,
                            child: GestureDetector(
                              onTap: () async {
                                await Provider.of<QuizProvider>(context, listen: false)
                                    .fetchQuizzes(categories[index]['name']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => QuizScreen()),
                                );
                              },
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(color: Colors.teal[200]!, width: 1),
                                ),
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      categories[index]['icon'],
                                      size: 36,
                                      color: categories[index]['color'],
                                    ).animate().shimmer(duration: const Duration(milliseconds: 1000)),
                                    const SizedBox(height: 12),
                                    Text(
                                      categories[index]['name'],
                                      style: GoogleFonts.poppins(
                                        fontSize: screenWidth > 600 ? 20 : 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueGrey[800],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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