import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/models/user_model.dart';
import '../widgets/my_profile.dart';
import '../../../core/widgets/navbar.dart';
import '../../../core/widgets/footer.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'package:renty/features/products/widgets/product_card.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF1F1F1F),
        body: Center(child: Text('No user logged in', style: TextStyle(color: Colors.white))),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF1F1F1F),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Navbar(email: fbUser.email ?? '',onToggleTheme: () {
            // Aquí puedes cambiar el tema. Si usas Provider o Bloc, lo conectas aquí.
            print('Cambiar tema (modo claro/oscuro)');
          },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<UserModel>(
                  stream: AuthService().userStream(fbUser.uid),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (userSnapshot.hasError || !userSnapshot.hasData) {
                      return const Center(
                        child: Text('Error loading profile', style: TextStyle(color: Colors.white)),
                      );
                    }
                    final user = userSnapshot.data!;
                    return Column(
                      children: [
                        MyProfile(
                          user: user,
                          onEditProfile: () => Navigator.pushNamed(context, '/profile_settings'),
                          onVerifyAccount: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Verify Account tapped')),
                          ),
                          onAddProduct: () => Navigator.pushNamed(context, '/add-product'),
                        ),
                        const Divider(color: Colors.white24),
                        Container(
                          color: const Color(0xFF1F1F1F),
                          child: const TabBar(
                            indicatorColor: Colors.white,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: 'My Listings'),
                              Tab(text: 'Reviews'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 400, // Altura fija para TabBarView
                          child: TabBarView(
                            children: [
                              const MyListingsTab(),
                              Center(
                                child: Text(
                                  'Aquí irán las reseñas',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24), // Espacio antes del footer
                const FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyListingsTab extends StatelessWidget {
  const MyListingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) return const SizedBox();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('ownerId', isEqualTo: fbUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'My Listings (0)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'No hay nada todavía',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/add-product'),
                  child: const Text('Add Product'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    var doc = snapshot.data!.docs[index];
                    var product = ProductModel.fromFirestore(doc);
                    return Stack(
                      children: [
                        ProductCard(product: product),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white),
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  '/edit-product',
                                  arguments: doc.id,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _showDeleteDialog(context, doc.id),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  childCount: snapshot.data!.docs.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, String productId) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar producto'),
          content: const Text('¿Estás seguro de que quieres eliminar este producto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deleteProduct(context, productId);
                Navigator.pop(context);
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(BuildContext context, String productId) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto eliminado exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar producto: $e')),
      );
    }
  }
}