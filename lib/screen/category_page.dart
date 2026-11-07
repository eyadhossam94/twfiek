import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.title, required this.image, this.company});
  final String title;
  final String image;
  final String? company;

  @override
  Widget build(BuildContext context) {
    const brand = Color(0xff47287E);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FB),
      appBar: AppBar(title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: AspectRatio(
              aspectRatio: 1.15,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 22),
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: brand)),
          const SizedBox(height: 8),
          Text(
            company == null
                ? 'Explore this category at Twfiek. Product availability and prices will appear here once the store catalogue is connected.'
                : 'Showing the $title category with your selected brand: $company. Product availability and prices will appear here once the store catalogue is connected.',
            style: const TextStyle(fontSize: 14, height: 1.6, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
            child: const Row(
              children: [
                Icon(Icons.inventory_2_outlined, color: brand),
                SizedBox(width: 12),
                Expanded(child: Text('Product catalogue is ready for your Firebase inventory data.')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
