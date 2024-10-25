import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const HandCricketGame());
}

class HandCricketGame extends StatelessWidget {
  const HandCricketGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hand Cricket',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green[50],
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int playerScore = 0;
  int computerScore = 0;
  int playerChoice = 0;
  int computerChoice = 0;
  bool isPlayerBatting = true;
  bool isGameOver = false;
  final random = Random();

  void playTurn(int choice) {
    if (isGameOver) return;

    setState(() {
      playerChoice = choice;
      computerChoice = random.nextInt(6) + 1; // 1 to 6

      if (playerChoice == computerChoice) {
        // Out!
        if (isPlayerBatting) {
          isPlayerBatting = false;
          if (computerScore > playerScore) {
            isGameOver = true;
          }
        } else {
          isGameOver = true;
        }
      } else {
        if (isPlayerBatting) {
          playerScore += playerChoice;
        } else {
          computerScore += computerChoice;
          if (computerScore > playerScore) {
            isGameOver = true;
          }
        }
      }
    });
  }

  void resetGame() {
    setState(() {
      playerScore = 0;
      computerScore = 0;
      playerChoice = 0;
      computerChoice = 0;
      isPlayerBatting = true;
      isGameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hand Cricket'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Scoreboard
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                )
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Score',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('You'),
                        Text(
                          playerScore.toString(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Computer'),
                        Text(
                          computerScore.toString(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Game Status
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  isPlayerBatting ? 'You are batting' : 'Computer is batting',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (playerChoice != 0) ...[
                  const SizedBox(height: 10),
                  Text('You chose: $playerChoice'),
                  Text('Computer chose: $computerChoice'),
                ],
                if (isGameOver)
                  Text(
                    playerScore > computerScore
                        ? 'You won! 🎉'
                        : 'Computer won! 👾',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
              ],
            ),
          ),

          // Number Buttons
          if (!isGameOver)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: List.generate(
                6,
                (index) => ElevatedButton(
                  onPressed: () => playTurn(index + 1),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    minimumSize: const Size(60, 60),
                  ),
                  child: Text('${index + 1}'),
                ),
              ),
            ),

          // Reset Button
          if (isGameOver)
            ElevatedButton.icon(
              onPressed: resetGame,
              icon: const Icon(Icons.refresh),
              label: const Text('Play Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}