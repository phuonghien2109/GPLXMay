import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/helpers/constants.dart';
import 'package:user/providers/quiz_provider.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
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
                const Text(
                  'Bảng Xếp Hạng',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: kBackgroundColor),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 20, bottom: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kBackgroundColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    children: const[
                      Text(
                        'Tên'
                      ),
                      Spacer(),
                      Text('Điểm')
                    ],
                  ),
                ),
                if (provider.users.isEmpty)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final user = provider.users[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                user.photoUrl,
                              ),
                            ),
                            title: Text(
                              user.name,
                            ),
                            trailing: Text(
                              user.score.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: provider.users.length,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final provider = context.read<QuizProvider>();
    provider.getAllUsers();
  }
}
