import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_cricket/core/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  final ValueNotifier<double> _currentPageNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _currentPageNotifier.value = _pageController.page ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Dummy Data for Cards
  List<Map<String, dynamic>> gameCards = [
    {
      'title': 'Quick Match',
      'score': '9,689',
      'color': Colors.amber[200],
      'image': 'assets/images/ball.png',
      'button_text': 'Play Now'

    },
    {
      'title': 'Practice Match',
      'score': '12,678',
      'color': Colors.green[200],
      'image': 'assets/images/wickets.png',
      'button_text': 'Practice Now'
    },
    {
      'title': 'Leaderboard',
      'score': '15,234',
      'color': Colors.blue[200],
      'image': 'assets/images/podium.png',
      'button_text': 'Your Stats'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PhysicalModel(
                        color: Colors.white,
                        elevation: 2.0,
                        shape: BoxShape.circle,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            menuIcon,
                            colorFilter: const ColorFilter.mode(
                                Colors.black87, BlendMode.srcIn),
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "4590",
                            style: GoogleFonts.mavenPro(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SvgPicture.asset(
                            scoreBallIcon,
                            width: 24,
                            height: 24,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Hand Cricket",
                  style: GoogleFonts.mavenPro(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),

              const SizedBox(
                height: 16.0,
              ),

              // Card Stack (Carousel)
              SizedBox(
                height: 320.0,
                width: double.maxFinite,
                child: ValueListenableBuilder<double>(
                  valueListenable: _currentPageNotifier,
                  builder: (context, currentPage, child) {
                    return PageView.builder(
                      controller: _pageController,
                      itemCount: gameCards.length,
                      itemBuilder: (context, index) {
                        double scale = 1.0;

                        // Calculate scaling based on the current page
                        if (index == currentPage.floor()) {
                          scale = 1.0 - (currentPage - index) * 0.1;
                        } else if (index == currentPage.floor() + 1) {
                          scale = 0.9 + (currentPage - index + 1) * 0.1;
                        } else if (index == currentPage.floor() - 1) {
                          scale = 0.9 + (index - currentPage + 1) * 0.1;
                        } else {
                          scale = 0.9;
                        }

                        return Transform.scale(
                          scale: scale,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 4.0, bottom: 12.0),
                              child: GameCard(card: gameCards[index])),
                        );
                      },
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final Map<String, dynamic> card;
  const GameCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(32.0),
      elevation: 8,
      color: card['color'],
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: 20,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                card['image'],
                width: 150,
                height: 150,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card['title'],
                        style: GoogleFonts.mavenPro(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card['score'],
                        style: GoogleFonts.mavenPro(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  onPressed: () {
                    print("Play ${card['title']}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          card['button_text'],
                          style: GoogleFonts.mavenPro(
                            fontSize: 18.0, 
                            fontWeight: FontWeight.w600,
                            color: Colors.black87
                            ),
                          ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black87,
                          size: 24.0,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
