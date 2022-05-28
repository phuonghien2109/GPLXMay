import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:user/helpers/constants.dart';
import 'package:user/models/question.dart';
import 'package:user/providers/quiz_provider.dart';

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
                // const Text(
                //   'Tìm kiếm câu hỏi',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w500,
                //       color: kBackgroundColor),
                // ),
                // Container(
                //   margin: const EdgeInsets.only(top: 10, right: 20, bottom: 20),
                //   decoration: const BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(
                //         color: kBackgroundColor,
                //         width: 1.0,
                //       ),
                //     ),
                //   ),
                // ),
                TypeAheadField<User>(
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
                  itemBuilder: (context, User suggestion) {
                    final user = suggestion;
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text(
                        user.subtitle,
                        maxLines: 1,
                      ),
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
                  onSuggestionSelected: (User suggestion) {
                    setState(() {
                      final user = suggestion;
                      controller.text = user.name;
                      MainNoti(user: user);
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
  final User user;

  MainNoti({
    required this.user,
  });

  @override
  notifyListeners();
}

class User {
  final String name;
  final String subtitle;

  const User({required this.name, required this.subtitle});
}

class UserData {
  static final List<User> users = List.generate(
    6,
    (index) => User(
        name: _questions[index].question, subtitle: _questions[index].explain),
  );

  static List<User> getSuggestions(String query) =>
      List.of(users).where((user) {
        final userLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return userLower.contains(queryLower);
      }).toList();
}
