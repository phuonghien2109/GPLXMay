import 'package:flutter/material.dart';
import 'package:user/helpers/constants.dart';
import 'package:user/screens/home/components/home.dart';
import 'package:user/screens/home/components/noti.dart';
import 'package:user/screens/home/components/search.dart';
import 'package:user/screens/home/components/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final _home = const Home();
  final _search = const Search();
  final _noti = const Noti();
  final _setting = const Setting();

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _home;
    } else if (selectedIndex == 1) {
      return _search;
    } else if (selectedIndex == 2) {
      return _noti;
    } else {
      return _setting;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: const Text('Ôn Thi Giấy Phép Lái Xe Máy'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            onTap: (index) {
              onTapHandler(index);
            },
            currentIndex: selectedIndex,
            unselectedItemColor: Colors.white54,
            backgroundColor: Colors.transparent,
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.home),
                title: Text(
                  'Trang Chủ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.search,
                ),
                title: Text(
                  'Tìm kiếm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.notifications,
                ),
                title: Text('Thông báo', style: TextStyle(color: Colors.white)),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.settings,
                ),
                title: Text('Cài đặt', style: TextStyle(color: Colors.white)),
              )
            ]),
        body: getBody(),
      ),
    );
  }
}
