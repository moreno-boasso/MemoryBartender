import 'package:flutter/material.dart';
import '../../styles/colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: MemoColors.beige,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              const SizedBox(width: 10.0),
              const Icon(Icons.search_outlined, color: MemoColors.brownie),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cerca cocktails...',
                    hintStyle: TextStyle(color: MemoColors.brownie.withOpacity(0.8)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
