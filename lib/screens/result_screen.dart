import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../providers/quiz_provider.dart';
import 'leaderboard_screen.dart'; // Import LeaderboardScreen

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _playCompleteSound();
  }

  void _playCompleteSound() async {
    await _audioPlayer.play(AssetSource('sounds/complete.mp3'));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth > 600 ? 32.0 : 12.0;
    final quizProvider = Provider.of<QuizProvider>(context);

    if (quizProvider.score >= 70) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _confettiController.play();
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: Card(
                          elevation: 6,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AvatarGlow(
                                      glowColor: Colors.teal,
                                      duration: const Duration(milliseconds: 2000),
                                      repeat: true,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.teal[400],
                                        radius: 16,
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Pemain: ${quizProvider.username}',
                                      style: GoogleFonts.poppins(
                                        fontSize: screenWidth > 600 ? 20 : 16,
                                        color: Colors.blueGrey[800],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Icon(
                                  Icons.star,
                                  size: 60,
                                  color: Colors.teal,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Hasil Kuis!',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth > 600 ? 34 : 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[800],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Kategori: ${quizProvider.selectedCategory}',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth > 600 ? 20 : 16,
                                    color: Colors.blueGrey[800],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ZoomIn(
                                  duration: const Duration(milliseconds: 1000),
                                  child: Text(
                                    'Skor: ${quizProvider.score}/100',
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth > 600 ? 26 : 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey[800],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  quizProvider.score >= 50
                                      ? 'Mantap, Bro! 🎉'
                                      : 'Ayo coba lagi, Bro! 💪',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth > 600 ? 20 : 16,
                                    color: Colors.blueGrey[800],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    quizProvider.resetQuiz();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.leaderboard,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  label: Text(
                                    'Lihat Leaderboard',
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth > 600 ? 20 : 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal[400],
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
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
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.teal,
                Colors.blueGrey,
                Colors.green,
                Colors.yellow,
                Colors.red,
              ],
              numberOfParticles: 20,
              minBlastForce: 5,
              maxBlastForce: 20,
            ),
          ),
        ],
      ),
    );
  }
}