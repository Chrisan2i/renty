import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../features/rentals/views/rental_requests_page.dart';

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({super.key});

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<QueryDocumentSnapshot> _notifications = [];

  Future<void> _loadNotifications() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();

    setState(() {
      _notifications = snapshot.docs;
    });
  }

  void _handleNotificationTap(BuildContext context, Map<String, dynamic> data, String docId) async {
    // Marcar como leída
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(docId)
        .update({'read': true});

    _removePopup();

    // Validar el tipo
    final type = data['type'];
    final requestId = data['requestId'];

    if (type == 'rental_request' && requestId != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyRentalRequestsPage()));
    }
  }

  void _showPopupMenu(BuildContext context) async {
    await _loadNotifications();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 300,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(-260, 50),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF1E1E1E),
            child: _notifications.isEmpty
                ? const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'No tienes notificaciones nuevas.',
                style: TextStyle(color: Colors.white70),
              ),
            )
                : ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: _notifications.length,
              separatorBuilder: (_, __) =>
              const Divider(color: Colors.white24),
              itemBuilder: (context, index) {
                final doc = _notifications[index];
                final data = doc.data() as Map<String, dynamic>;

                return ListTile(
                  leading: const Icon(Icons.notifications_active,
                      color: Colors.white),
                  title: Text(
                    data['title'] ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    data['message'] ?? '',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: (data['read'] == false)
                      ? const Icon(Icons.circle,
                      color: Color(0xFF0085FF), size: 10)
                      : null,
                  onTap: () => _handleNotificationTap(
                    context,
                    data,
                    doc.id,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return _iconButton(Icons.notifications, () {});
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('notifications')
            .where('userId', isEqualTo: user.uid)
            .where('read', isEqualTo: false)
            .limit(1)
            .get(),
        builder: (context, snapshot) {
          final hasNotification =
              snapshot.hasData && snapshot.data!.docs.isNotEmpty;

          return Stack(
            children: [
              IconButton(
                onPressed: () {
                  if (_overlayEntry == null) {
                    _showPopupMenu(context);
                  } else {
                    _removePopup();
                  }
                },
                icon: const Icon(Icons.notifications,
                    color: Colors.grey, size: 22),
                splashRadius: 20,
              ),
              if (hasNotification)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0085FF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.grey, size: 22),
      splashRadius: 20,
    );
  }
}