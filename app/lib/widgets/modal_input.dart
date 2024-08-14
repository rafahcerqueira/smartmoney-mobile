import 'package:smart_money/enums/input_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModalInput extends StatefulWidget {
  final String label;
  final String initialValue;
  final ModalInputType type;

  const ModalInput({
    super.key,
    required this.label,
    required this.initialValue,
    required this.type,
  });

  @override
  _ModalInputState createState() => _ModalInputState();
}

class _ModalInputState extends State<ModalInput> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: _controller,
      obscureText: widget.type == ModalInputType.password,
      keyboardType: widget.type == ModalInputType.number
          ? TextInputType.number
          : TextInputType.text,
      onTap: widget.type == ModalInputType.date
          ? () {
              FocusScope.of(context).requestFocus(FocusNode());
              _selectDate(context);
            }
          : null,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 100, 100, 100)),
        filled: true,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100)),
        ),
      ),
      style: const TextStyle(color: Color.fromARGB(255, 100, 100, 100)),
    );
  }
}