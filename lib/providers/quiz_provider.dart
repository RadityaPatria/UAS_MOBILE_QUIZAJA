import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../services/api_service.dart';

class QuizProvider with ChangeNotifier {
  List<Quiz> _quizzes = [];
  int _currentIndex = 0;
  int _score = 0;
  int _userId = 0;
  String _username = '';
  String _selectedCategory = '';
  final int _questionLimit = 10;
  int _timeLeft = 10;

  List<Quiz> get quizzes => _quizzes;
  int get currentIndex => _currentIndex;
  int get score => _score;
  String get selectedCategory => _selectedCategory;
  int get questionLimit => _questionLimit;
  int get timeLeft => _timeLeft;
  String get username => _username;
  int get userId => _userId; // Tambah getter untuk userId

  final ApiService _apiService = ApiService();

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setTimeLeft(int time) {
    _timeLeft = time;
    notifyListeners();
  }

  Future<void> fetchQuizzes(String category) async {
    _selectedCategory = category;
    _quizzes = await _apiService.getQuizzes(category, _questionLimit);
    _currentIndex = 0;
    _score = 0;
    _timeLeft = 10;
    notifyListeners();
  }

  void nextQuestion(String selectedOption) {
    if (_quizzes[_currentIndex].correctAnswer == selectedOption) {
      _score += 10;
    }
    _currentIndex++;
    _timeLeft = 10;
    notifyListeners();

    if (_currentIndex >= _quizzes.length) {
      _apiService.saveScore(_userId, _username, _score, _selectedCategory);
    }
  }

  void skipQuestion() {
    _currentIndex++;
    _timeLeft = 10;
    notifyListeners();

    if (_currentIndex >= _quizzes.length) {
      _apiService.saveScore(_userId, _username, _score, _selectedCategory);
    }
  }

  void resetQuiz() {
    _quizzes = [];
    _currentIndex = 0;
    _score = 0;
    _selectedCategory = '';
    _timeLeft = 10;
    notifyListeners();
  }
}