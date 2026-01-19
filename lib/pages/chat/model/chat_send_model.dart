class ChatsendModel {
  final String sid;
  final String rid;
  final String? message;
  final String sendertype;

  ChatsendModel({
    required this.sid,
    required this.rid,
    required this.sendertype,
    this.message,
  });
  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      'sid': sid,
      'rid': rid,
      'message': message ?? "",
      'type': 'hospital',
      'stype': sendertype,
      'hid': sid,
    };
  }
}
