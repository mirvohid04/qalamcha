import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qalamcha/models/user_model.dart';
import 'package:qalamcha/pages/chat/ChatPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/AppColors.dart';
import '../floating/ContactPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int itemCount = 0;
  bool isLocked = true;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  String? userName;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future _load() async {
    var sharedPreference = await SharedPreferences.getInstance();
    var json = await sharedPreference.getString("user");
    var map = jsonDecode(json!);
    print(map);
    userModel = UserModel.fromJson(map);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.main_blue_900,
      appBar: AppBar(
        backgroundColor: Color(0xff04070a),
        toolbarHeight: 60,
        title: Row(
          children: [
            CircleAvatar(backgroundColor: Colors.red, radius: 22),
            SizedBox(width: 12),
            Container(
              constraints: BoxConstraints(maxWidth: size.width - 180),
              child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text:  userModel.firstName != null ? "${userModel.firstName}" : "zaybal ",


                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [TextSpan(text: "Qayumov")],
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLocked = !isLocked;
                });
              },
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300), // animation vaqti
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  isLocked ? Icons.lock : Icons.lock_open,
                  // qulflangan yoki yo‘q
                  key: ValueKey<bool>(isLocked), // AnimatedSwitcher uchun kerak
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 18),
            ImageIcon(
              AssetImage("assets/icons/search.png"),
              size: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround_images/backround.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                width: size.width,
                height: 40,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfff0e68c),
                      Color(0xffafeeee),
                      Color(0xff00004d),
                      Color(0xffa219ff),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(1),
                  height: 34,
                  decoration: BoxDecoration(
                    color: Color(0xff04070a),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: itemCount == 0
                            ? Alignment.centerLeft
                            : itemCount == 1
                            ? Alignment.center
                            : Alignment.centerRight,
                        child: Container(
                          width: (size.width - 4) / 3 - 12,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.sky_blue_100,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  itemCount = 0;
                                });
                                _pageController.animateToPage(
                                  0,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Center(
                                child: Text(
                                  "Flow",
                                  style: TextStyle(
                                    color: itemCount == 0
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  itemCount = 1;
                                });
                                _pageController.animateToPage(
                                  1,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Center(
                                child: Text(
                                  "Private",
                                  style: TextStyle(
                                    color: itemCount == 1
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  itemCount = 2;
                                });
                                _pageController.animateToPage(
                                  2,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Center(
                                child: Text(
                                  "Groups",
                                  style: TextStyle(
                                    color: itemCount == 2
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      itemCount = index;
                    });
                  },
                  children: [
                    _widget(),
                    Center(child: Text("🔍 Search Page")),
                    Center(child: Text("⚙️ Settings Page")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 5),
        child: GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (builder) => ContactPage()));
          },
          child: Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfff0e68c),
                  Color(0xffafeeee),
                  Color(0xff00004d),
                  Color(0xffa219ff),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 44,
              height: 44,
              padding: EdgeInsets.all(1),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Color(0xff04070a),
              ),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffafeeee),
                ),

                child: ImageIcon(
                  AssetImage("assets/icons/edit.png"),
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _widget() {
    Size size = MediaQuery.of(context).size;
    return ListView.separated(
      separatorBuilder: (context, index) =>
          Divider(color: Colors.blueGrey.shade100, thickness: 0.8, indent: 66),
      itemCount: 30,
      itemBuilder: (context, asyncSnapshot) {
        return Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (builder) => ChatPage()));
            },
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.sky_blue_500,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width - 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: size.width * 0.5,
                            ),
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: "Anvar ",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [TextSpan(text: "Qayumov")],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.check,
                                size: 20,
                                color: Colors.lightGreenAccent,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "22:16",
                                style: TextStyle(
                                  color: AppColors.orange_100,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: size.width - 90,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: size.width - 150,
                            ),
                            child: Text(
                              "AEDassaalomu dfkfjhf hjdfbdjhaf hjfbjhb  fhfvhu jhfberfh jhfbru assolomu alakum fg hgfgks ghgjkrhg  hgjhg hskh kjhgh k hjkhg hhh kjhgk hk kjhgkhj jkhkjh kh h gh khk d",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.orange_100,

                                fontSize: 13,
                              ),
                            ),
                          ),
                          IntrinsicWidth(
                            child: Container(
                              height: 19,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              constraints: BoxConstraints(
                                minWidth: 19,
                                maxWidth: 55,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.greenAccent.shade400,
                              ),
                              child: Center(
                                child: Text(
                                  "2",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
