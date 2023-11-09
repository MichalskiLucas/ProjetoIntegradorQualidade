// ignore_for_file: file_names, library_private_types_in_public_api

import '../app/data/models/ingredient_model.dart';
import 'package:flutter/material.dart';

class DropdownMenuIngredient extends StatefulWidget {
  const DropdownMenuIngredient({
    Key? key,
    required this.onSelected,
    required this.listIngredient,
  }) : super(key: key);

  final void Function(IngredientModel?) onSelected;
  final List<IngredientModel> listIngredient;

  @override
  _DropdownMenuIngredientState createState() => _DropdownMenuIngredientState();
}

class _DropdownMenuIngredientState extends State<DropdownMenuIngredient> {
  IngredientModel? selectedIngredient;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<IngredientModel>(
      hint: selectedIngredient != null
          ? Text(selectedIngredient.toString())
          : const Text("Selecione um Ingrediente"),
      value: selectedIngredient,
      onChanged: (newValue) {
        setState(() {
          selectedIngredient = newValue!;
          widget.onSelected(selectedIngredient);
        });
      },
      items: widget.listIngredient.map((IngredientModel value) {
        return DropdownMenuItem<IngredientModel>(
          value: value,
          child: Text(
            value.descricao!,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      iconSize: 24,
      isExpanded: true,
      underline: Container(
        height: 1,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
