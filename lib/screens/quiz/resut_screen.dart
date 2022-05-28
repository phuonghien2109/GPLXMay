import 'package:flutter/material.dart';
import 'package:user/components/buttonwidget.dart';
import 'package:user/helpers/constants.dart';
import 'package:user/models/question.dart';
import 'package:user/providers/quiz_provider.dart';
import 'package:user/screens/home/homepage.dart';
import 'package:user/screens/quiz/quiz_screen.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
    required this.score,
    required this.questions,
    required this.totalTime,
    required this.listscore,
  }) : super(key: key);

  final int score;
  final List<Question> questions;
  final List<int> listscore;
  final int totalTime;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Kết Quả Bài Kiểm Tra',
                style: TextStyle(
                    color: kColor, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              if (widget.score > 20)
                SizedBox(
                  width: 300,
                  child: Image.asset('assets/pass_test.png'),
                ),
              if (widget.score < 21)
                SizedBox(
                  width: 300,
                  child: Image.asset('assets/fail_test.png'),
                ),
              Text(
                ' ${widget.score}/25 câu',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              if (widget.score < 21)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Bạn cần phải đúng 21/25 câu hỏi để vượt qua bài kiểm tra này',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 30),
              ButtonWidget(
                title: 'Test Again',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        totalTime: widget.totalTime,
                        questions: widget.questions,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              ButtonWidget(
                title: 'Thoát',
                onTap: () {
                  Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => const HomePage(),
                      ),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final provider = context.read<QuizProvider>();
    provider.updateHighscore(widget.score, widget.listscore);
  }
}
