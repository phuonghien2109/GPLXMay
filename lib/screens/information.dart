import 'package:flutter/material.dart';
import 'package:user/helpers/constants.dart';

class Infomation extends StatefulWidget {
  const Infomation({Key? key}) : super(key: key);

  @override
  State<Infomation> createState() => _InfomationState();
}

class _InfomationState extends State<Infomation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông Tin Ứng Dụng',
        ),
        foregroundColor: Colors.white,
        backgroundColor: kColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Text(
              'Nếu bạn gặp vấn đề nào về phần mềm, vui lòng liên hệ qua hòm thư Email: OnThiGPLXMay@gmail.com.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Chúc các bạn đạt được kết quả thi tốt nhất!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
