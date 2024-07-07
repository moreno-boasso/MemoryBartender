import 'package:flutter/material.dart';
import '../../styles/colors.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String, String, bool) onSearch;

  const CustomSearchBar({required this.onSearch, super.key});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFilter = 'Nome'; // Inizialmente selezionato 'Nome'

  String get hintText {
    if ( == 'Nome') {
      return 'Cerca cocktails...';
    } else if (_selectedFilter == 'Ingrediente') {
      return 'Cerca ingrediente...';
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchTextChanged);
    super.dispose();
  }

  void _onSearchTextChanged() {
    if (_controller.text.isEmpty) {
      widget.onSearch('', _selectedFilter, false); // false indica ricerca non manuale
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: MemoColors.beige,
        borderRadius: BorderRadius.circular(16.0),
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
                controller: _controller,
                decoration: InputDecoration(
                  hintText: hintText, // Utilizza il valore dinamico di hintText
                  hintStyle: TextStyle(color: MemoColors.brownie.withOpacity(0.8)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(fontSize: 16.0),
                onSubmitted: (value) {
                  widget.onSearch(value, _selectedFilter, true); // true indica ricerca manuale
                },
              ),
            ),
            DropdownButton<String>(
              value: _selectedFilter,
              items: <String>['Nome', 'Ingrediente'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedFilter = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
