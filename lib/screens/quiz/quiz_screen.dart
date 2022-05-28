import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:user/helpers/constants.dart';
import 'package:user/models/question.dart';
import 'package:user/screens/quiz/resut_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
    required this.totalTime,
    required this.questions,
  }) : super(key: key);

  final int totalTime;
  final List<Question> questions;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late int _currentTime;
  late Timer _timer;
  int _currentIndex = 0;
  var index = Random().nextInt(160);
  String _selectedAnswer = '';
  late var random = [];
  int _score = 0;
  late final List<int> _listscore = [];

  @override
  void initState() {
    super.initState();
    _currentTime = widget.totalTime;
    print(index);

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _currentTime -= 1;
      });

      if (_currentTime == 0) {
        _timer.cancel();
        pushResultScreen(context);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[index];
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      LinearProgressIndicator(
                        value: _currentTime / widget.totalTime,
                      ),
                      Center(
                        child: Text(
                          '${_currentTime.toString()} phút',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height - 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(120),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Câu hỏi ${_currentIndex + 1}:',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (currentQuestion.state == true)
                          const Text(
                            '(Câu Điểm Liệt)',
                            style: TextStyle(fontSize: 20, color: kRedColor),
                          ),
                      ],
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, right: 20, bottom: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      currentQuestion.question,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (currentQuestion.image != '')
                      Center(
                        child: Image(
                          image: NetworkImage(currentQuestion.image),
                          height: 200,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (int i = 0; i < currentQuestion.answers.length; i++)
                      if (currentQuestion.answers[i] != '')
                        AnswerTile(
                          isSelected:
                              currentQuestion.answers[i] == _selectedAnswer,
                          answer: currentQuestion.answers[i],
                          correctAnswer: currentQuestion.correctAnswer,
                          onTap: () {
                            setState(
                              () {
                                _selectedAnswer = currentQuestion.answers[i];
                              },
                            );
                          },
                        ),
                    Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          if (_selectedAnswer ==
                              currentQuestion.correctAnswer) {
                            _score++;
                          }
                          if (currentQuestion.state == true &&
                              _selectedAnswer !=
                                  currentQuestion.correctAnswer) {
                            pushResultScreen(context);
                          } else {
                            nextQuestion();
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xFF11969f),
                            ),
                            child: const Text(
                              'Câu hỏi tiếp theo',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pushResultScreen(BuildContext context) {
    _listscore.add(_score);
    DateTime now = DateTime.now();

    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString()}-${now.minute.toString()}";

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          questions: widget.questions,
          totalTime: widget.totalTime,
          score: _score,
          listscore: _listscore,
        ),
      ),
    );
  }

  void nextQuestion() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_currentIndex == 24) {
        pushResultScreen(context);
        return;
      }

      random.add(index);

      var _index = Random().nextInt(160);

      for (int i = 0; i < random.length; i++) {
        while (_index == random[i]) {
          _index = Random().nextInt(160);
        }
      }

      setState(() {
        index = _index;
        _currentIndex++;
        _selectedAnswer = '';
      });
      print(index);
    });
  }
}

class AnswerTile extends StatelessWidget {
  const AnswerTile({
    Key? key,
    required this.isSelected,
    required this.answer,
    required this.correctAnswer,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String answer;
  final String correctAnswer;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: getTheRightColor(), width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () => onTap(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: getTheRightColor() == kGrayColor
                    ? null
                    : getTheRightColor(),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: getTheRightColor(),
                ),
              ),
              child: getTheRightColor() == kGrayColor
                  ? null
                  : Icon(
                      getTheRightIcon(),
                      size: 16,
                      color: Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Color getTheRightColor() {
    if (!isSelected) return kGrayColor;

    if (answer == correctAnswer) {
      return Colors.green;
    }

    return Colors.redAccent;
  }

  IconData getTheRightIcon() {
    return getTheRightColor() == Colors.redAccent ? Icons.close : Icons.done;
  }
}
