import 'package:flutter/material.dart';
import 'package:user/helpers/constants.dart';
import 'package:user/models/question.dart';

class Questionscreen extends StatefulWidget {
  const Questionscreen({Key? key, required this.questions}) : super(key: key);

  final List<Question> questions;

  @override
  _QuestionscreenState createState() => _QuestionscreenState();
}

class _QuestionscreenState extends State<Questionscreen> {
  bool _showBackToTopButton = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Câu hỏi ôn tập'),
        elevation: 0,
        backgroundColor: kColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          final _question = widget.questions[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Câu hỏi ${index + 1}: ${_question.question}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (_question.image != '')
                  Center(
                    child: Image(
                      image: NetworkImage(_question.image),
                      height: 200,
                    ),
                  ),
                for (int i = 0; i < _question.answers.length; i++)
                  if (_question.answers[i] != '')
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        '${i + 1}. ${_question.answers[i]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Đáp án: ${_question.correctAnswer}',
                  style: const TextStyle(color: kColor, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (_question.explain != '')
                  Text(
                    'Giải Thích: ${_question.explain}',
                    style:
                        TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }
}
