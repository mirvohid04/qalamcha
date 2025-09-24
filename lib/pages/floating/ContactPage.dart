import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _texController = TextEditingController();
  bool _menuTime = true;
  bool _textField = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff04070a),
        toolbarHeight: 60,
        leading: GestureDetector(
          onTap: () {
            if (_textField == true) {
              Navigator.of(context).pop();
            } else {
              setState(() {
                _textField = true;
              });
            }
          },
          child: Icon(Icons.arrow_back, size: 24, color: Colors.white),
        ),

        title: _textField
            ? SizedBox(
                width: size.width - 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Yangi xabar",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _textField = !_textField;
                            });
                          },
                          child: ImageIcon(
                            AssetImage("assets/icons/search.png"),
                            size: 17,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(width: 16),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _menuTime = !_menuTime;
                            });
                          },
                          child: _menuTime
                              ? ImageIcon(
                                  AssetImage("assets/icons/menu_time.png"),
                                  size: 33,
                                  color: Colors.white,
                                )
                              : ImageIcon(
                                  AssetImage("assets/icons/menu_aa.png"),
                                  size: 32,
                                  color: Colors.white,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width - 130,
                    child: TextField(
                      controller: _texController,
                      cursorColor: Colors.white,
                      cursorWidth: 1.8,
                      cursorHeight: 22,
                      decoration: InputDecoration(
                        hintText: "Qidiruv",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none, // border yo‘q
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _texController,
                    builder: (context, value, child) {
                      return value.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () => _texController.clear(),
                              child: Icon(
                                Icons.close,
                                size: 24,
                                color: Colors.white,
                              ),
                            )
                          : SizedBox.shrink();
                    },
                  ),
                ],
              ),
      ),
      body: Container(
        decoration: BoxDecoration(
          //color: Color(0xff090c1a),
          gradient: LinearGradient(
            colors: [Color(0xff090c1a), Color(0xff15164f)],
            end: Alignment.bottomRight,
            begin: Alignment.topLeft,
          ),
          //image: DecorationImage(image: AssetImage("assets/backround_images/backround.jpg"),fit: BoxFit.cover)
        ),
        width: size.width,
        height: size.height,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.white, size: 26),
                      SizedBox(width: 18),
                      Text(
                        "Yangi kontakt",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                childCount: 3,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  padding: EdgeInsets.only(left: 18),
                  width: size.width,
                  height: 28,
                  color: Colors.black,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _menuTime
                        ? Text(
                            "Oxirgi faollik bo'yicha tartiblash",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            "Ismlar bo'yicha tartiblash",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 2),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 24),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
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
                          SizedBox(height: 1),

                          Text(
                            "data",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                childCount: 30,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 5),
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

            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            width: 44,
            height: 44,
            padding: EdgeInsets.all(1),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Color(0xff04070a),
            ),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
