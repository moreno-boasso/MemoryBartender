import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Importa AutoSizeText
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
    if (_selectedFilter == 'Nome') {
      return 'Cerca cocktail...';
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

  void _onFilterChanged(String? newValue) {
    setState(() {
      _selectedFilter = newValue!;
      _controller.clear(); // Questa riga cancella il testo nel TextField
    });
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
            const Icon(Icons.search_outlined, color: MemoColors.brownie),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: MemoColors.brownie.withOpacity(0.8),fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(fontSize: 14.0),
                onSubmitted: (value) {
                  widget.onSearch(value, _selectedFilter, true); // true indica ricerca manuale
                },
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedFilter,
                items: <String>['Nome', 'Ingrediente'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: AutoSizeText(
                      value,
                      maxLines: 1,
                      style: TextStyle(fontSize: 14.0), //todo: MemoText style
                    ),
                  );
                }).toList(),
                onChanged: _onFilterChanged, // Chiamata al metodo _onFilterChanged
              ),
            ),
          ],
        ),
      ),
    );
  }
}
