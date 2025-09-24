import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _voiceCamera = true;

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(color: Colors.blue)),
            Container(
              padding: EdgeInsets.only(left: 4, right: 4),
              color: Colors.white,
              width: size.width,
              constraints: BoxConstraints(minHeight: 54,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _messageController,
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 11),
                        child: SizedBox(
                          width: 35,
                          child:
                            value.text.isEmpty
                                ? ImageIcon(
                                    AssetImage("assets/icons/gifs.png"),
                                    size: 30,
                                    color: Colors.black,
                                  )
                                :  ImageIcon(
                              AssetImage("assets/icons/smiley.png"),
                              size: 28,
                              color: Colors.black,
                            ),

                        ),
                      );
                    },
                  ),
                  SizedBox(width: 5),

                  Expanded(
                          child: TextField(
                            maxLines: 7,
                            minLines: 1,

                            controller: _messageController,
                            cursorColor: Colors.black,
                            cursorWidth: 1.8,
                            cursorHeight: 22,
                            decoration: InputDecoration(
                              hintText: "Xabar",
                              contentPadding:_messageController.text.isEmpty? EdgeInsets.only(bottom: 2):EdgeInsets.only(bottom: 14),
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.2,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),


                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _messageController,
                    builder: (context, value, child) {
                      return value.text.isNotEmpty
                          ? Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: IconButton(
                                  icon: ImageIcon(AssetImage("assets/icons/send.png"),size: 23,color: Colors.blueGrey.shade700,),
                                  onPressed: () {
                                    if (_messageController.text.isNotEmpty) {
                                      _messageController.clear();
                                    }
                                  },
                                ),
                              )

                          : Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: SizedBox(
                                height: 28,
                                child: Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage("assets/icons/paper_clip.png"),
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 12),
                                    SizedBox(
                                      width: 40,
                                      //height: 26,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _voiceCamera = !_voiceCamera;
                                          });
                                        },
                                        child: _voiceCamera
                                            ? ImageIcon(
                                                AssetImage(
                                                  "assets/icons/camera.png",
                                                ),
                                                size: 28,
                                                color: Colors.black,
                                              )
                                            : ImageIcon(
                                                AssetImage(
                                                  "assets/icons/microphone.png",
                                                ),
                                                size: 24,
                                                color: Colors.black,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
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
