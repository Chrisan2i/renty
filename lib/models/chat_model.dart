class ChatModel {
  final String chatId;
  final String rentalId;
  final String productId;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastTimestamp;

  ChatModel({
    required this.chatId,
    required this.rentalId,
    required this.productId,
    required this.participants,
    required this.lastMessage,
    required this.lastTimestamp,
  });

  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'rentalId': rentalId,
    'productId': productId,
    'participants': participants,
    'lastMessage': lastMessage,
    'lastTimestamp': lastTimestamp.toIso8601String(),
  };

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    chatId: json['chatId'],
    rentalId: json['rentalId'],
    productId: json['productId'],
    participants: List<String>.from(json['participants']),
    lastMessage: json['lastMessage'],
    lastTimestamp: DateTime.parse(json['lastTimestamp']),
  );
}

class MessageModel {
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool seen;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.seen,
  });

  Map<String, dynamic> toJson() => {
    'senderId': senderId,
    'text': text,
    'timestamp': timestamp.toIso8601String(),
    'seen': seen,
  };

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    senderId: json['senderId'],
    text: json['text'],
    timestamp: DateTime.parse(json['timestamp']),
    seen: json['seen'],
  );
}
