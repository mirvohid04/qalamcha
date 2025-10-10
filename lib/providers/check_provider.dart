import 'package:flutter/material.dart';

class CheckProvider extends ChangeNotifier {
  // Xabarlar statuslarini saqlash (messageId -> status)
  Map<String, String> _statusMap = {};
  // status olish
  String getStatus(String messageId) {
    return _statusMap[messageId] ?? "sending";
  }
  // status yangilash
  void setStatus(String messageId, String status) {
    _statusMap[messageId] = status;
    notifyListeners();
  }
  // statusga qarab icon
  Icon getIcon(String messageId, bool isMe) {
    if (!isMe) return Icon(Icons.circle,size: 0,color: Colors.black,);
    final status = _statusMap[messageId] ?? "sending";
    switch (status) {
      case "sending":
        return Icon(Icons.access_time_outlined, size: 16, color: Colors.red);
      case "sent":
        return Icon(Icons.check, size: 16, color: Colors.grey);
      case "delivered":
        return Icon(Icons.done_all, size: 16, color: Colors.green);
      case "seen":
        return Icon(Icons.circle_outlined, size: 16, color: Colors.orange);
      default:
        return Icon(Icons.access_time_outlined, size: 16, color: Colors.red);
    }
  }
}
