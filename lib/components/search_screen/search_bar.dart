import 'dart:async'; // Importa per il Timer
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
  Timer? _debounce;

  String get hintText {
    switch (_selectedFilter) {
      case 'Nome':
        return 'Cerca cocktail...';
      case 'Ingrediente':
        return 'Cerca ingrediente...';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchTextChanged);
    _controller.dispose();
    _debounce?.cancel(); // Assicurati di annullare il timer quando il widget viene distrutto
    super.dispose();
  }

  void _onSearchTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      String trimmedValue = _controller.text.trim();
      widget.onSearch(trimmedValue, _selectedFilter, true);
    });
  }

  void _onFilterChanged(String? newValue) {
    setState(() {
      _selectedFilter = newValue!;
      _controller.clear();
    });
    widget.onSearch('', _selectedFilter, false);
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
                  hintStyle: TextStyle(color: MemoColors.brownie.withOpacity(0.8)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(fontSize: 16.0),
                onChanged: (value) {
                  _onSearchTextChanged(); // Richiama la funzione con debounce
                },
              ),
            ),
            const SizedBox(width: 10.0),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedFilter,
                items: <String>['Nome', 'Ingrediente'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: _onFilterChanged,
                icon: const Icon(Icons.filter_alt, color: MemoColors.brownie),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
