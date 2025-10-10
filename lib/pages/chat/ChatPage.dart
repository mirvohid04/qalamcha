import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qalamcha/providers/check_provider.dart';

import '../../service/realtime_database/ChatService.dart';

class ChatPage extends StatefulWidget {
  final String otherUserId;
  const ChatPage({super.key, required this.otherUserId,});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _voiceCamera = true;
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();

  late String currentUserId;
  late String chatId;



  @override
  void initState() {
    super.initState();

    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    chatId=_chatService.getChatId(currentUserId, widget.otherUserId);
    _chatService.markAsSeen(chatId, currentUserId);
  }

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: StreamBuilder<Map<dynamic, dynamic>>(
                  stream: _chatService.getMessagesId(chatId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    final messages = snapshot.data as Map;


                      if(messages.isEmpty){
                        return Text("Hozircha xabarlar mavjud emas");
                      }

                      return ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var entries = snapshot.data!.entries.toList();
                          entries.sort((a, b) =>
                              (b.value['timestamp'] as int).compareTo(a.value['timestamp'] as int));
                          var messageId = entries[index].key;
                          var message = entries[index].value['text'];

                          var senderId = entries[index].value['userId'];
                          bool isMe = senderId == currentUserId;
                          var status = entries[index].value['status']??"sending";
                          return InkWell(
                            onLongPress: (){
                              _chatService.deleteMessageId(chatId,messageId);
                            },
                            child: Align(
                              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical:1),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: size.width*0.8,

                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),

                                  decoration: BoxDecoration(
                                    color: isMe ? Colors.blue[300] : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12),

                                  ),
                                  child: Column(
                                    children: [
                                      Text(message.toString(),style: TextStyle(
                                          fontSize: 16,
                                          height: 1.2
                                      ),),
                                      Consumer<CheckProvider>(builder: (context,statusP,_){
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          statusP.setStatus(messageId, status);
                                        });                                        return statusP.getIcon(messageId, isMe);
                                      }),

                                    ],
                                  ),),
                              ),
                            ),
                          );
                        },
                      );

                  },
                ),
              ),
            ),
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
                                      _chatService.sendMessageId( chatId,  _messageController.text, currentUserId
                                      );
                                      _messageController.clear();

                                      if (_scrollController.hasClients) {
                                        _scrollController.animateTo(
                                          0.0,
                                          duration: Duration(milliseconds: 10),
                                          curve: Curves.easeOut,
                                        );
                                      }

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
