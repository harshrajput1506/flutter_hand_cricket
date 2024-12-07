import 'package:flutter/material.dart';
class CardStackScreen extends StatefulWidget {
  @override
  _CardStackScreenState createState() => _CardStackScreenState();
}

class _CardStackScreenState extends State<CardStackScreen> {
  List<String> cards = ['Card 1', 'Card 2', 'Card 3', 'Card 4', 'Card 5'];
  double _dragPositionX = 0.0;
  double _dragPositionY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('Deck of Cards', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: cards.reversed.map((card) {
            int index = cards.indexOf(card);
            bool isTopCard = index == 0;
            return AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              left: isTopCard ? _dragPositionX : 0,
              top: isTopCard ? _dragPositionY : 10.0 * index,
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (isTopCard) {
                    setState(() {
                      _dragPositionX += details.delta.dx;
                      _dragPositionY += details.delta.dy;
                    });
                  }
                },
                onPanEnd: (details) {
                  if (_dragPositionX.abs() > 100 || _dragPositionY.abs() > 100) {
                    _moveTopCardToBottom();
                  } else {
                    _resetPosition();
                  }
                },
                child: AnimatedScale(
                  scale: isTopCard ? 1.0 : 1 - (0.05 * index),
                  duration: Duration(milliseconds: 300),
                  child: CardWidget(
                    cardText: card,
                    isTopCard: isTopCard,
                    cardColor: _getCardColor(index),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _moveTopCardToBottom() {
    setState(() {
      String topCard = cards.removeAt(0);
      cards.add(topCard);
      _dragPositionX = 0;
      _dragPositionY = 0;
    });
  }

  void _resetPosition() {
    setState(() {
      _dragPositionX = 0;
      _dragPositionY = 0;
    });
  }

  Color _getCardColor(int index) {
    List<Color> colors = [
      Colors.redAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
    ];
    return colors[index % colors.length];
  }
}

class CardWidget extends StatelessWidget {
  final String cardText;
  final bool isTopCard;
  final Color cardColor;

  const CardWidget({
    Key? key,
    required this.cardText,
    required this.isTopCard,
    required this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        
      ),
      child: Center(
        child: Text(
          cardText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}