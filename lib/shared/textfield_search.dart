import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const SearchField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xffF5F4F8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xffEEEEF2),
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search ...",
          hintStyle: const TextStyle(
            color: Color(0xffA5A3AE),
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xff8B5CF6),
            size: 25,
          ),
          suffixIcon: IconButton(
            onPressed: () => controller.clear(),
            icon: const Icon(
              Icons.close_rounded,
              color: Color(0xffA5A3AE),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 17,
          ),
        ),
      ),
    );
  }
}