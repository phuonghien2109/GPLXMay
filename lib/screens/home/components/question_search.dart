import 'package:flutter/material.dart';
import 'package:user/helpers/constants.dart';
import 'package:user/models/question.dart';

class QuestionSearch extends StatefulWidget {
  const QuestionSearch({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  State<QuestionSearch> createState() => _QuestionSearchState();
}

class _QuestionSearchState extends State<QuestionSearch> {
  @override
  Widget build(BuildContext context) {
    final _question = widget.question;
    return Column(
      children: [
        Text(
          'Câu hỏi: ${_question.question}',
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
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
      ],
    );
  }
}
