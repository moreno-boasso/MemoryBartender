import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cocktail.dart';
import '../styles/colors.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File? _image;
  bool _isAlcoholic = true;
  final List<Map<String, String>> _ingredients = [];
  String _instructions = '';
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addIngredient() {
    setState(() {
      _ingredients.add({'ingredient': '', 'amount': ''});
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  Future<void> _saveCocktail() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final name = _nameController.text;

      String? imageBase64;
      if (_image != null) {
        final imageBytes = await _image!.readAsBytes();
        imageBase64 = base64Encode(imageBytes);
      }

      final newCocktail = Cocktail(
        id: DateTime.now().toString(),
        name: name,
        imageUrl: imageBase64 ?? '',
        isAlcoholic: _isAlcoholic,
        ingredients: _ingredients,
        instructions: _instructions,
      );

      final prefs = await SharedPreferences.getInstance();
      final cocktails = prefs.getStringList('cocktails') ?? [];
      final cocktailJson = jsonEncode(newCocktail.toJson());
      cocktails.add(cocktailJson);
      await prefs.setStringList('cocktails', cocktails);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cocktail salvato con successo!'),
        ),
      );

      _clearInputs();
    }
  }

  void _clearInputs() {
    setState(() {
      _nameController.clear();
      _image = null;
      _isAlcoholic = true;
      _ingredients.clear();
      _instructions = '';
    });
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galleria'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Fotocamera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea Cocktail'),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildImagePicker(),
              const SizedBox(height: 25),
              _buildNameField(),
              const SizedBox(height: 25),
              _buildAlcoholicSwitch(),
              const SizedBox(height: 25),
              _buildIngredientsSection(),
              const SizedBox(height: 25),
              _buildInstructionsField(),
              const SizedBox(height: 25),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: _image == null
                    ? Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child:  Icon(
                    Icons.photo_library,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                )
                    : Image.file(
                  _image!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              if (_image != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _image = null;
                        });
                      },
                      iconSize: 26,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _showImageSourceActionSheet,
          icon: const Icon(
            Icons.photo,
            color: MemoColors.brownie,
          ),
          label: const Text(
            'Inserisci Copertina',
            style: TextStyle(color: MemoColors.brownie),
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nome del Cocktail:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Nome',
            labelStyle: TextStyle(color: MemoColors.brownie),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Inserisci un nome';
            }
            return null;
          },
          onSaved: (value) {
            if (value != null) {
              _nameController.text = value;
            }
          },
        ),
      ],
    );
  }

  Widget _buildAlcoholicSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "E' Alcolico:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Alcolico'),
          value: _isAlcoholic,
          onChanged: (value) => setState(() => _isAlcoholic = value),
          activeColor: MemoColors.brownie,
        ),
      ],
    );
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inserisci Ingredienti:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ..._ingredients.asMap().entries.map((entry) {
          final index = entry.key;
          final ingredient = entry.value;
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              title: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ingrediente e Quantità',
                  labelStyle: TextStyle(color: MemoColors.brownie),
                ),
                initialValue: ingredient['ingredient'],
                onChanged: (value) {
                  setState(() {
                    _ingredients[index]['ingredient'] = value;
                  });
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: MemoColors.brownie),
                onPressed: () => _removeIngredient(index),
              ),
            ),
          );
        }).toList(),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _addIngredient,
          style: ElevatedButton.styleFrom(
            backgroundColor: MemoColors.beige,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: const Center(
            child: Text(
              'Aggiungi Ingrediente',
              style: TextStyle(
                color: MemoColors.brownie,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Inserisci Istruzioni:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Istruzioni',
            labelStyle: TextStyle(color: MemoColors.brownie),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
          maxLines: 5,
          initialValue: _instructions,
          onSaved: (value) => _instructions = value!,
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveCocktail,
      child: const Text('Crea Cocktail'),
    );
  }
}
