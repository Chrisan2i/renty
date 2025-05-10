import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renty/features/chat/models/chat_model.dart';
import 'package:renty/features/chat/views/chat_page.dart';
import 'package:renty/features/chat/services/chat_service.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Center(child: Text('Usuario no autenticado'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tus chats')),
      body: StreamBuilder<List<ChatModel>>(
        stream: ChatService().getUserChats(currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final chats = snapshot.data ?? [];

          if (chats.isEmpty) {
            return const Center(child: Text('No tienes chats activos.'));
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              final otherUser = chat.participants.firstWhere(
                    (id) => id != currentUser.uid,
                orElse: () => 'Desconocido',
              );

              return ListTile(
                title: Text('Chat con: $otherUser'),
                subtitle: Text(chat.lastMessage.isNotEmpty
                    ? chat.lastMessage
                    : 'Sin mensajes aún'),
                trailing: Text(
                  chat.lastTimestamp.toLocal().toString().split(' ')[0],
                  style: const TextStyle(fontSize: 12),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        chatId: chat.chatId,
                        otherUserId: otherUser,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
