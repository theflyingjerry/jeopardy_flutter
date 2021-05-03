import 'package:flutter/material.dart';
import 'package:jeopardy/questions.dart';

void main() => runApp(MaterialApp(home: Jeopardy()));

class Jeopardy extends StatefulWidget {
  @override
  _JeopardyState createState() => _JeopardyState();
}

class _JeopardyState extends State<Jeopardy> {
  QuestionGetter theGoods = QuestionGetter();
  String answerLabel = '';
  String categoryLabel = 'Jeopardy!';
  String questionLabel = 'Touch to Start';
  int winnings = 0;
  Color cBlue = Color.fromRGBO(6, 12, 233, 1.0);
  Color cYellow = Color.fromRGBO(255, 204, 0, 1.0);
  bool swiped = false;
  @override
  Widget build(BuildContext context) {
    //theGoods.alexTrebeck(questionNum);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/BG.jpg'), fit: BoxFit.cover)),
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            int sensitivity = 10;
            if (details.delta.dx > sensitivity && swiped == false) {
              setState(() {
                winnings += theGoods.amount;
                swiped = true;
              });
            } else if (details.delta.dx < -sensitivity && swiped == false) {
              setState(() {
                winnings -= theGoods.amount;
                swiped = true;
              });
            }
          },
          onVerticalDragUpdate: (details) {
            if (details.delta.dy > -20) {
              setState(() {
                answerLabel = theGoods.answer.toUpperCase();
              });
            }
          },
          onTap: () async {
            await theGoods.alexTrebeck();
            await theGoods.checker();
            setState(() {
              // theGoods.alexTrebeck();
              categoryLabel =
                  '${theGoods.category}: ${theGoods.amount.toString()}';
              questionLabel = '${theGoods.question}';
              answerLabel = 'Swipe up to reveal answer';
              swiped = false;
            });
          },
          child: Stack(
            children: [
              Container(
                  padding: EdgeInsets.only(bottom: 180),
                  child: Text(
                    answerLabel,
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.grey[200],
                        fontFamily: 'Jeopardy'),
                  ),
                  alignment: Alignment.bottomCenter),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 120.0, horizontal: 24),
                child: Card(
                  color: cBlue,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 25),
                    height: 220,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          categoryLabel,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Swiss 911',
                              color: cYellow),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(questionLabel.toUpperCase(),
                            style: TextStyle(
                                color: Colors.grey[200],
                                fontSize: 16,
                                fontFamily: 'Korina',
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.visible)
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 8, 0),
                      alignment: Alignment.topRight,
                      child: Text('Score: $winnings',
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 20,
                              fontFamily: 'Swiss 911')))),
            ],
          ),
        ),
      ),
    );
  }
}
