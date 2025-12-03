import 'dart:math';

import 'package:flutter/material.dart';

import 'question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const List<Question> _questionData = [
    Question(
      questionText: 'Some cats are actually allergic to humans',
      questionAnswer: true,
    ),
    Question(
      questionText: 'You can lead a cow down stairs but not up stairs.',
      questionAnswer: false,
    ),
    Question(
      questionText:
          'Approximately one quarter of human bones are in the feet.',
      questionAnswer: true,
    ),
    Question(
      questionText: 'A slug\'s blood is green.',
      questionAnswer: true,
    ),
    Question(
      questionText: 'Buzz Aldrin\'s mother\'s maiden name was "Moon".',
      questionAnswer: true,
    ),
    Question(
      questionText: 'It is illegal to pee in the Ocean in Portugal.',
      questionAnswer: true,
    ),
    Question(
      questionText:
          'No piece of square dry paper can be folded in half more than 7 times.',
      questionAnswer: false,
    ),
    Question(
      questionText:
          'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
      questionAnswer: true,
    ),
    Question(
      questionText:
          'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
      questionAnswer: false,
    ),
    Question(
      questionText:
          'The total surface area of two human lungs is approximately 70 square metres.',
      questionAnswer: true,
    ),
    Question(
      questionText: 'Google was originally called "Backrub".',
      questionAnswer: true,
    ),
    Question(
      questionText:
          'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
      questionAnswer: true,
    ),
    Question(
      questionText:
          'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
      questionAnswer: true,
    ),
  ];

  late final List<Question> _questionBank;

  int _questionIndex = 0;
  int _correctAnswers = 0;
  bool _isQuizFinished = false;
  final List<Icon> _scoreKeeper = [];

  @override
  void initState() {
    super.initState();
    _questionBank = List<Question>.from(_questionData)
      ..shuffle(Random());
  }

  void _checkAnswer(bool userPickedAnswer) {
    if (_isQuizFinished) {
      return;
    }

    final Question currentQuestion = _questionBank[_questionIndex];
    final bool isCorrect = userPickedAnswer == currentQuestion.questionAnswer;

    setState(() {
      _scoreKeeper.add(
        Icon(
          isCorrect ? Icons.check : Icons.close,
          color: isCorrect ? Colors.green : Colors.red,
        ),
      );

      if (isCorrect) {
        _correctAnswers++;
      }

      if (_questionIndex >= _questionBank.length - 1) {
        _isQuizFinished = true;
      } else {
        _questionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _isQuizFinished
                    ? 'Quiz complete! Final score: $_correctAnswers/${_questionBank.length}'
                    : _questionBank[_questionIndex].questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: _isQuizFinished ? null : () => _checkAnswer(true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: _isQuizFinished ? null : () => _checkAnswer(false),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _scoreKeeper,
                  ),
                ),
              ),
              Text(
                'Score: $_correctAnswers/${_questionBank.length}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
