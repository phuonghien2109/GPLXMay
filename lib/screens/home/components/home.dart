import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/providers/quiz_provider.dart';
import 'package:user/screens/meothi.dart';
import 'package:user/screens/question/question_screen.dart';
import 'package:user/screens/quiz/quiz_screen.dart';
import 'package:user/screens/traffic_signs/traffic_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final authUser = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (authUser != null)
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xin Chào, ${authUser.displayName!} !',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: "Dancing",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Bạn đã sẵn sàng chưa?',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Dancing",
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Product(
                  title: "Đề Thi Thử Ngẫu Nhiên",
                  image: "logo_test.png",
                  link: QuizScreen(
                    totalTime: provider.totalTime,
                    questions: provider.questions,
                  ),
                ),
                Product(
                  title: "Câu Hỏi Ôn Tập",
                  image: "logo_question.png",
                  link: Questionscreen(
                    questions: provider.questions,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Product(
                  title: "Biển Báo",
                  image: "logo_bienbao.png",
                  link: const TrafficScreen(),
                ),
                Product(
                  title: "Mẹo Thi",
                  image: "logo_meothi.png",
                  link: Meothi(),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Product extends StatelessWidget {
  Product(
      {Key? key, required this.image, required this.title, required this.link})
      : super(key: key);

  String image;
  String title;
  Widget link;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => link,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: SizedBox(
          height: size.height * 0.2,
          width: size.width * 0.4,
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(90))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/" + image,
                    width: 70,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
