import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../services/api_service.dart';
import 'home_screen.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late Future<List<Map<String, dynamic>>> _leaderboardFuture;

  @override
  void initState() {
    super.initState();
    _leaderboardFuture = ApiService().getLeaderboard();
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
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.teal,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.leaderboard,
                            size: 36,
                            color: Colors.teal,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Leaderboard',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth > 600 ? 34 : 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[800],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 40), // Untuk balancing layout
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Daftar Leaderboard
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _leaderboardFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.teal),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Gagal memuat leaderboard: ${snapshot.error}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.red[400],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            'Belum ada data leaderboard!',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.blueGrey[800],
                            ),
                          ),
                        );
                      }

                      final leaderboard = snapshot.data!;
                      // Kelompokkan data berdasarkan kategori
                      Map<String, List<Map<String, dynamic>>> groupedByCategory = {};
                      for (var entry in leaderboard) {
                        final category = entry['category'] as String;
                        if (!groupedByCategory.containsKey(category)) {
                          groupedByCategory[category] = [];
                        }
                        groupedByCategory[category]!.add(entry);
                      }

                      return ListView.builder(
                        itemCount: groupedByCategory.length,
                        itemBuilder: (context, index) {
                          final category = groupedByCategory.keys.elementAt(index);
                          final entries = groupedByCategory[category]!;
                          // Batasi hanya Top 3
                          final top3Entries = entries.take(3).toList();

                          return FadeInUp(
                            duration: Duration(milliseconds: 400 + (index * 100)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(color: Colors.teal[200]!, width: 1),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.category,
                                            color: Colors.teal,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            category,
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth > 600 ? 22 : 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: top3Entries.length,
                                        itemBuilder: (context, idx) {
                                          final entry = top3Entries[idx];
                                          // Tentukan ikon medali berdasarkan peringkat
                                          String medalIcon;
                                          if (idx == 0) {
                                            medalIcon = '🥇'; // Medali emas untuk peringkat 1
                                          } else if (idx == 1) {
                                            medalIcon = '🥈'; // Medali perak untuk peringkat 2
                                          } else {
                                            medalIcon = '🥉'; // Medali perunggu untuk peringkat 3
                                          }

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                            child: Row(
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
                                                        child: Text(
                                                          medalIcon,
                                                          style: const TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      entry['username'],
                                                      style: GoogleFonts.poppins(
                                                        fontSize: screenWidth > 600 ? 18 : 14,
                                                        color: Colors.blueGrey[800],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Skor: ${entry['score']}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: screenWidth > 600 ? 18 : 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.teal[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Tombol Kembali ke Beranda
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: Text(
                        'Kembali ke Beranda',
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