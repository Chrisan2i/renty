import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VerificationStatusView extends StatelessWidget {
  const VerificationStatusView({super.key});

  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return 'Desconocido';
    final date = timestamp.toDate();
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  Widget _buildStatusBadge(String status) {
    late Color color;
    late String label;

    switch (status) {
      case 'approved':
        color = const Color(0xFF00C853);
        label = 'Approved';
        break;
      case 'rejected':
        color = const Color(0xFFFF3B3B);
        label = 'Rejected';
        break;
      default:
        color = const Color(0xFFFF9900);
        label = 'Reviewing';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDocumentCard(String label, String url, String date, String status) {
    return Container(
      width: 750,
      height: 77,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    )),
                Text("Submitted: $date",
                    style: const TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 14,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: _buildStatusBadge(status),
          )
        ],
      ),
    );
  }

  Widget _buildTimeline(String submittedAt) {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verification Timeline',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const CircleAvatar(radius: 8, backgroundColor: Color(0xFF0085FF)),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Documents Submitted',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    submittedAt,
                    style: const TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const CircleAvatar(radius: 8, backgroundColor: Color(0xFFFF9900)),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Under Review',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Estimated completion: 1–2 business days',
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>?;
          final verification = data?['identityVerification'];

          if (verification == null) {
            return const Center(
              child: Text(
                'No verification data found.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final String status = verification['status'] ?? 'under_review';
          final String submittedAt = _formatDate(verification['submittedAt']);

          final docs = {
            'Cédula - Parte frontal': verification['frontImageUrl'],
            'Cédula - Parte trasera': verification['backImageUrl'],
            'Selfie con la cédula': verification['selfieWithIdUrl'],
            'Prueba de residencia': verification['residenceProofUrl'],
          };

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Verification Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Track the status of your submitted verification documents',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: 800,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF222222),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            CircleAvatar(
                              backgroundColor: Color(0xFF0085FF),
                              radius: 32,
                              child: Icon(Icons.verified, size: 32, color: Colors.white),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Documents Under Review',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'We are currently processing your verification documents',
                          style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                        ),
                        const SizedBox(height: 24),
                        for (final entry in docs.entries)
                          if (entry.value != null)
                            _buildDocumentCard(
                              entry.key,
                              entry.value,
                              submittedAt,
                              status,
                            ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTimeline(submittedAt),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
