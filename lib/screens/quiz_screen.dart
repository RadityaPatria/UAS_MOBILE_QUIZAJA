import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../models/quiz.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Timer? _timer;
  String? _selectedOption;
  bool _isAnswered = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (quizProvider.timeLeft <= 0) {
        setState(() {
          _isAnswered = true;
        });
        quizProvider.skipQuestion();
        if (quizProvider.currentIndex >= quizProvider.quizzes.length) {
          timer.cancel();
          _timer = null;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ResultScreen()),
          );
        } else {
          setState(() {
            _selectedOption = null;
            _isAnswered = false;
          });
        }
      } else {
        quizProvider.setTimeLeft(quizProvider.timeLeft - 1);
      }
    });
  }

  void _playSound(bool isCorrect) async {
    await _audioPlayer.play(AssetSource(isCorrect ? 'sounds/correct.mp3' : 'sounds/wrong.mp3'));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth > 600 ? 32.0 : 12.0;

    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (quizProvider.quizzes.isEmpty) {
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
              child: const Center(
                child: CircularProgressIndicator(color: Colors.teal),
              ),
            ),
          );
        }

        if (quizProvider.currentIndex >= quizProvider.quizzes.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _timer?.cancel();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ResultScreen()),
            );
          });
          return const SizedBox.shrink();
        }

        final currentQuiz = quizProvider.quizzes[quizProvider.currentIndex];
        final options = [
          {'text': currentQuiz.optionA, 'value': 'A'},
          {'text': currentQuiz.optionB, 'value': 'B'},
          {'text': currentQuiz.optionC, 'value': 'C'},
          {'text': currentQuiz.optionD, 'value': 'D'},
        ];

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressIndicator(quizProvider, screenWidth),
                    const SizedBox(height: 16),
                    _buildQuestionCard(currentQuiz, screenWidth),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _buildOptionsList(options, quizProvider, screenWidth),
                    ),
                    const SizedBox(height: 8),
                    _buildSkipButton(quizProvider),
                    const SizedBox(height: 8), // Kurangi space bawah
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator(QuizProvider quizProvider, double screenWidth) {
    return FadeInDown(
      duration: const Duration(milliseconds: 800),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Tambah padding
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                          fontSize: screenWidth > 600 ? 18 : 14,
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.teal,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Skor: ${quizProvider.score}',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth > 600 ? 18 : 14,
                          color: Colors.teal[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.category,
                        color: Colors.teal,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Kategori: ${quizProvider.selectedCategory}',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth > 600 ? 18 : 14,
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Colors.teal,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Waktu: ${quizProvider.timeLeft}',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth > 600 ? 18 : 14,
                          color: quizProvider.timeLeft <= 3
                              ? Colors.red[400]
                              : Colors.blueGrey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: (quizProvider.currentIndex + 1) / quizProvider.quizzes.length,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.question_answer,
                    color: Colors.teal,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Pertanyaan ${quizProvider.currentIndex + 1}/${quizProvider.quizzes.length}',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth > 600 ? 18 : 14,
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Quiz currentQuiz, double screenWidth) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.teal[200]!, width: 1),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              currentQuiz.question,
              style: GoogleFonts.poppins(
                fontSize: screenWidth > 600 ? 22 : 18,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsList(List<Map<String, String>> options, QuizProvider quizProvider, double screenWidth) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, idx) {
        var option = options[idx];
        bool isSelected = _selectedOption == option['value'];
        bool isCorrect = quizProvider.quizzes[quizProvider.currentIndex].correctAnswer == option['value'];

        return FadeInUp(
          duration: Duration(milliseconds: 400 + (idx * 100)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: ElevatedButton(
              onPressed: _isAnswered
                  ? null
                  : () {
                      setState(() {
                        _selectedOption = option['value'];
                        _isAnswered = true;
                      });
                      _playSound(isCorrect);
                      quizProvider.nextQuestion(option['value']!);
                      if (quizProvider.currentIndex >= quizProvider.quizzes.length) {
                        _timer?.cancel();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ResultScreen()),
                        );
                      } else {
                        setState(() {
                          _selectedOption = null;
                          _isAnswered = false;
                        });
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: _isAnswered && isSelected
                        ? (isCorrect ? Colors.green[300]! : Colors.red[300]!)
                        : Colors.teal[200]!,
                    width: 1,
                  ),
                ),
                backgroundColor: _isAnswered
                    ? (isSelected
                        ? (isCorrect ? Colors.green[100] : Colors.red[100])
                        : Colors.white)
                    : Colors.white,
                elevation: 3,
                shadowColor: Colors.grey[300],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${String.fromCharCode(65 + idx)}. ${option['text']}',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth > 600 ? 18 : 14,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                  ),
                  _isAnswered && isSelected
                      ? Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green[400] : Colors.red[400],
                          size: 20,
                        )
                      : const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.teal,
                          size: 14,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkipButton(QuizProvider quizProvider) {
    return Align(
      alignment: Alignment.center,
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: TextButton.icon(
          onPressed: _isAnswered
              ? null
              : () {
                  setState(() {
                    _isAnswered = true;
                  });
                  quizProvider.skipQuestion();
                  if (quizProvider.currentIndex < quizProvider.quizzes.length) {
                    setState(() {
                      _selectedOption = null;
                      _isAnswered = false;
                    });
                  }
                },
          icon: const Icon(
            Icons.skip_next,
            color: Colors.teal,
            size: 20,
          ),
          label: Text(
            'Lewati Pertanyaan',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.teal[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}