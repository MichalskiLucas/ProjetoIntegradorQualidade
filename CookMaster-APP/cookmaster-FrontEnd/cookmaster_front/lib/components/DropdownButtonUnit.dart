// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:cookmaster_front/app/data/models/unitMeansure_model.dart';
import 'package:flutter/material.dart';

class DropdownMenuUnitMeansure extends StatefulWidget {
  const DropdownMenuUnitMeansure(
      {Key? key, required this.onSelected, required this.listUnitMeansure})
      : super(key: key);

  final void Function(UnitMeansureModel) onSelected;
  final List<UnitMeansureModel> listUnitMeansure;

  @override
  _DropdownMenuUnitMeansureState createState() =>
      _DropdownMenuUnitMeansureState();
}

class _DropdownMenuUnitMeansureState extends State<DropdownMenuUnitMeansure> {
  UnitMeansureModel? selectedUnit;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<UnitMeansureModel>(
      hint: selectedUnit != null
          ? Text(selectedUnit!.descricao.toString())
          : const Text("Selecione uma Un. Medida"),
      value: selectedUnit,
      onChanged: (newValue) {
        setState(() {
          selectedUnit = newValue!;
          widget.onSelected(selectedUnit!);
        });
      },
      items: widget.listUnitMeansure.map((UnitMeansureModel value) {
        return DropdownMenuItem<UnitMeansureModel>(
          value: value,
          child: Text(
            value.descricao,
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
