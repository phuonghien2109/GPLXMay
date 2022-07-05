import 'package:flutter/material.dart';
import 'package:user/helpers/constants.dart';
import 'package:user/screens/Information.dart';
import 'package:user/screens/auth/sign_in.dart';
import 'package:user/screens/huongdansd.dart';
import 'package:user/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  static const routeName = './login';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.cover,
        ),
      ),
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
                const Text(
                  'Cài Đặt',
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HuongdanSD(),
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(right: 16, top: 16, bottom: 5),
                    alignment: Alignment.center,
                    // width: MediaQuery.of(context).size.width - 48,
                    child: Row(
                      children: const [
                        Icon(Icons.menu_book_rounded),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Hướng dẫn sử dụng',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Spacer(),
                        Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Infomation(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 16, top: 16),
                    alignment: Alignment.center,
                    // width: MediaQuery.of(context).size.width - 48,
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Thông tin ứng dụng',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Spacer(),
                        Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => launch('tel://0961508150'),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kColor, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.call),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Hotline hỗ trợ: 0961508150',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    AuthService.signOutWithGoogle();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 48,
                    child: const Text(
                      'Đăng Xuất',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
