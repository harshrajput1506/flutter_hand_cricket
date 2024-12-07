import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cards = [Colors.red[300], Colors.amber[200], Colors.brown[400]];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /// Background image using BoxDecoration
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        /// Main content
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "HAND CRICKET",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mavenPro(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text for better contrast
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 500,
                  width: 320,
                  child: Stack(
                    children: [
                      ...List.generate(
                          3,
                          (index) => GameCard(
                                card: cards[index]!,
                                depth: index,
                              )).reversed
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.card, required this.depth});

  final Color card;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: depth * 20,
      left: 0,
      right: 0,
      child: Card(
        color: card,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        elevation: 2,
        child: const SizedBox(
          height: 360,
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
