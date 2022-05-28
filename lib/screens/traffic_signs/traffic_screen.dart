import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/helpers/constants.dart';

class TrafficScreen extends StatefulWidget {
  const TrafficScreen({Key? key}) : super(key: key);

  @override
  _TrafficScreenState createState() => _TrafficScreenState();
}

class _TrafficScreenState extends State<TrafficScreen> {
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
        title: const Text(
          'Biển Báo Giao Thông',
        ),
        foregroundColor: Colors.white,
        backgroundColor: kColor,
        elevation: 0,
      ),
      backgroundColor: kColor,
      body: Container(
        padding: const EdgeInsets.all(5),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('BienBao').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
              controller: _scrollController,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return QuizTitle(
                    imgUrl: snapshot.data!.docs[index]['img'],
                    title: snapshot.data!.docs[index]['title'],
                    desc: snapshot.data!.docs[index]['subtitle'],
                  );
                });
          },
        ),
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

class QuizTitle extends StatelessWidget {
  final String imgUrl, title, desc;
  const QuizTitle(
      {Key? key, required this.imgUrl, required this.title, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imgUrl,
              height: 100,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    desc,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
