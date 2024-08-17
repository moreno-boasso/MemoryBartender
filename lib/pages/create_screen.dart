import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cocktail.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  File? _image;
  bool _isAlcoholic = true;
  List<Map<String, String>> _ingredients = [];
  String _instructions = '';
  final ImagePicker _picker = ImagePicker();

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

  Future<void> _saveCocktail() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String? imageBase64;
      if (_image != null) {
        List<int> imageBytes = await _image!.readAsBytes();
        imageBase64 = base64Encode(imageBytes);
      }

      Cocktail newCocktail = Cocktail(
        id: DateTime.now().toString(),
        name: _name,
        imageUrl: imageBase64 ?? '',
        isAlcoholic: _isAlcoholic,
        ingredients: _ingredients,
        instructions: _instructions,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> cocktails = prefs.getStringList('cocktails') ?? [];
      String cocktailJson = jsonEncode(newCocktail.toJson());
      cocktails.add(cocktailJson);
      await prefs.setStringList('cocktails', cocktails);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cocktail salvato con successo!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crea Cocktail'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildImagePicker(),
              SizedBox(height: 16),
              _buildNameField(),
              SizedBox(height: 16),
              _buildAlcoholicSwitch(),
              SizedBox(height: 16),
              _buildIngredientsSection(),
              SizedBox(height: 16),
              _buildInstructionsField(),
              SizedBox(height: 20),
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
        _image == null
            ? Card(
          elevation: 5,
          child: ListTile(
            title: Text('Nessuna immagine selezionata.'),
            trailing: Icon(Icons.image, color: Colors.deepOrange),
          ),
        )
            : Card(
          elevation: 5,
          child: Image.file(
            _image!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: Icon(Icons.camera_alt),
              label: Text('Fotocamera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: Icon(Icons.photo_library),
              label: Text('Galleria'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nome',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Inserisci un nome';
        }
        return null;
      },
      onSaved: (value) => _name = value!,
    );
  }

  Widget _buildAlcoholicSwitch() {
    return SwitchListTile(
      title: Text('Alcolico'),
      value: _isAlcoholic,
      onChanged: (value) => setState(() => _isAlcoholic = value),
      activeColor: Colors.deepOrange,
    );
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ingredienti', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ..._ingredients.map((ingredient) {
          int index = _ingredients.indexOf(ingredient);
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              contentPadding: EdgeInsets.all(8),
              title: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Ingrediente'),
                      onChanged: (value) {
                        _ingredients[index]['ingredient'] = value;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Quantità'),
                      onChanged: (value) {
                        _ingredients[index]['amount'] = value;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _ingredients.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: _addIngredient,
          child: Text('Aggiungi Ingrediente'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionsField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Istruzioni',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
      maxLines: 5,
      onSaved: (value) => _instructions = value!,
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveCocktail,
      child: Text('Salva Cocktail'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
