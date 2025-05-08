import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_model.dart';

class ChatService {
  final _chatRef = FirebaseFirestore.instance.collection('chats');

  // Crear un chat solo si no existe ya
  Future<void> createChatIfNotExists({
    required String rentalId,
    required String productId,
    required String ownerId,
    required String renterId,
  }) async {
    final existing = await _chatRef.where('rentalId', isEqualTo: rentalId).limit(1).get();

    if (existing.docs.isEmpty) {
      final doc = _chatRef.doc();
      final now = DateTime.now();

      final chat = ChatModel(
        chatId: doc.id,
        rentalId: rentalId,
        productId: productId,
        participants: [ownerId, renterId],
        lastMessage: '',
        lastTimestamp: now,
      );

      await doc.set(chat.toJson());
    }
  }

  // Enviar mensaje
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    final now = DateTime.now();

    final message = MessageModel(
      senderId: senderId,
      text: text,
      timestamp: now,
      seen: false,
    );

    final chatDoc = _chatRef.doc(chatId);

    await chatDoc.collection('messages').add(message.toJson());

    await chatDoc.update({
      'lastMessage': text,
      'lastTimestamp': now.toIso8601String(),
    });
  }

  // Obtener mensajes en tiempo real
  Stream<List<MessageModel>> getMessages(String chatId) {
    return _chatRef
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => MessageModel.fromJson(doc.data())).toList());
  }

  // Obtener todos los chats de un usuario (para Inbox)
  Stream<List<ChatModel>> getUserChats(String userId) {
    return _chatRef
        .where('participants', arrayContains: userId)
        .orderBy('lastTimestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList());
  }
}

