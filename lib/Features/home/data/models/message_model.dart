class MessageModel {
  final String? msgContent;
  final String? msgId;
  MessageModel(this.msgContent, this.msgId);

  factory MessageModel.fromJson(json) {
    return MessageModel(json['msg'] ?? '', json['id'] ?? '');
  }
}
