import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qalamcha/pages/auth/LoginPage.dart';
import 'package:qalamcha/pages/home/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class DrawerMenuPage extends StatefulWidget {
  const DrawerMenuPage({super.key});

  @override
  State<DrawerMenuPage> createState() => _DrawerMenuPageState();
}

class _DrawerMenuPageState extends State<DrawerMenuPage> {
 bool userAccount=true;
  UserModel userModel = UserModel();

  @override
  void initState() {
    super.initState();

    _load();
  }

  Future _load() async {
    var sharedPreference = await SharedPreferences.getInstance();
    var json = sharedPreference.getString("user");
    var map = jsonDecode(json!);
    userModel = UserModel.fromJson(map);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.86,
      child: Column(
        children: [
          SizedBox(
            height: 185,
            child: DrawerHeader(
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(color: Colors.blueGrey),

              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(radius: 35, backgroundColor: Colors.blue),
                      Icon(Icons.sunny, color: Colors.blue, size: 20),
                    ],
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        userAccount=!userAccount;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: userModel.firstName,
                    
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [ TextSpan( text: " ${userModel.lastName}")],
                              ),
                            ),
                            Text(
                              "${userModel.email}",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                       userAccount==false? Icon(Icons.arrow_drop_down, size: 30):Icon(Icons.arrow_drop_up),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
         userAccount? Column(
           children: [
             SizedBox(height: 5,),










             SizedBox(
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10),
                 child: Row(
                   children: [
                     CircleAvatar(radius: 19,backgroundColor: Colors.black,),
                     SizedBox(width: 12,),

                     RichText(
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       text: TextSpan(
                         text: userModel.firstName,

                         style: TextStyle(
                           fontSize: 17,
                           color: Colors.black,
                           fontWeight: FontWeight.w600,
                         ),
                         children: [ TextSpan( text: " ${userModel.lastName}")],
                       ),
                     ),


                   ],
                 ),
               ),
             ),
             _listName(name: "Hisob qo'shish", icon: Icons.add, page: LoginPage()),













             SizedBox(height: 8,),
             Container(
               width: double.infinity,
               height: 1,
               decoration:BoxDecoration(
                 color: Colors.black
               ) ,
             )
           ],
         ):SizedBox(),
      _listName(name: "Profilim", icon: Icons.person_outline_outlined, page: HomePage()),

          SizedBox(height: 8,),
          Container(width: double.infinity,height: 1,decoration: BoxDecoration(color: Colors.black),),
          _listName(name: "Yangi guruh", icon: Icons.group_outlined, page: HomePage()),
          _listName(name: "Yangi kanal", icon: Icons.campaign_outlined, page: HomePage()),


          _listName(name: "Kontaktlar", icon: Icons.person_outline, page: HomePage()),
          _listName(name: "Saqlangan xabarlar", icon: Icons.bookmark_border_outlined, page: HomePage()),
          _listName(name: "Sozlamalar", icon: Icons.settings_outlined, page: HomePage()),

          SizedBox(height: 8,),
          Container(width: double.infinity,height: 1,decoration: BoxDecoration(color: Colors.black),),
          _listName(name: "Qalamcha funksiyalari", icon: Icons.help_outline, page: HomePage()),


        ],
      ),
    );
  }

  Widget _listName({
    required String name,
    required IconData icon,
    required Widget page,
  }) {
    return SizedBox(
      height: 46,
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        leading: Icon(icon, size: 28),

        onTap: () {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (builder) => page));
        },
      ),
    );
  }
}
