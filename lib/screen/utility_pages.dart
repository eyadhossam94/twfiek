import 'package:flutter/material.dart';

const _brand = Color(0xff47287E);
const _background = Color(0xFFF7F6FB);

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: _background,
    appBar: AppBar(title: const Text('Shopping cart', style: TextStyle(fontWeight: FontWeight.w800))),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 112, height: 112,
              decoration: BoxDecoration(color: _brand.withValues(alpha: .08), shape: BoxShape.circle),
              child: const Icon(Icons.shopping_cart_outlined, size: 52, color: _brand),
            ),
            const SizedBox(height: 22),
            const Text('Your cart is empty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Products you add will appear here.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.storefront_outlined),
              label: const Text('Continue shopping'),
              style: FilledButton.styleFrom(backgroundColor: _brand),
            ),
          ],
        ),
      ),
    ),
  );
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: _background,
    appBar: AppBar(title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.w800))),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 112, height: 112,
              decoration: BoxDecoration(color: _brand.withValues(alpha: .08), shape: BoxShape.circle),
              child: const Icon(Icons.notifications_none_rounded, size: 52, color: _brand),
            ),
            const SizedBox(height: 22),
            const Text('You are all caught up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('New offers and order updates will show up here.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    ),
  );
}
