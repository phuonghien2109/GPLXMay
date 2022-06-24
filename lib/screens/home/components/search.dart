import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:user/helpers/constants.dart';
import 'package:user/models/question.dart';
import 'package:user/providers/quiz_provider.dart';
import 'package:user/screens/home/components/question_search.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

late List<Question> _questions;
TextEditingController controller = TextEditingController();

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    _questions = provider.questions;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(120),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TypeAheadField<Question>(
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: kColor,
                        ),
                        hintText: 'Tìm kiếm ...',
                        hintStyle: TextStyle(color: kColor)),
                    controller: controller,
                  ),
                  suggestionsCallback: UserData.getSuggestions,
                  itemBuilder: (context, Question suggestion) {
                    final user = suggestion;
                    return ListTile(
                      title: Text(user.question),
                    );
                  },
                  noItemsFoundBuilder: (context) => SizedBox(
                    height: 50,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                      child: const Text(
                        'Không tìm thấy',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  onSuggestionSelected: (Question suggestion) {
                    setState(() {
                      final user = suggestion;
                      // controller.text = user.question;
                      MainNoti(user: user);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)),
                                    // height:
                                        // MediaQuery.of(context).size.height * 0.5,
                                    child: QuestionSearch(
                                      question: user,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainNoti extends ChangeNotifier {
  final Question user;

  MainNoti({
    required this.user,
  });

  @override
  notifyListeners();
}

class UserData {
  static final List<Question> users = List.generate(
    6,
    (index) => Question(
      question: _questions[index].question,
      answers: _questions[index].answers,
      explain: _questions[index].explain,
      correctAnswer: _questions[index].correctAnswer,
      id: _questions[index].id,
      image: _questions[index].image,
      state: _questions[index].state,
    ),
  );

  static List<Question> getSuggestions(String query) =>
      List.of(users).where((user) {
        final userLower = user.question.toLowerCase();
        final queryLower = query.toLowerCase();

        return userLower.contains(queryLower);
      }).toList();
}
