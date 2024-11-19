import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset('assets/bg.jpg')),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.all(24),
              child: Text(
                'HAND CRICKET',
                style: GoogleFonts.mavenPro(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  shadows: [
                    const Shadow(
                      color: Colors.black,
                      offset: Offset(0, 4),
                      blurRadius: 0
                    ),
                  ]
                ),
                textAlign: TextAlign.center,
              ),)
            ],
          ),
        )
      ],

    );
  }
}