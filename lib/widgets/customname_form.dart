import 'package:flutter/material.dart';

class CustomNameTextFormField extends StatelessWidget {
  final IconData icons;
  final String hintText;
  const CustomNameTextFormField({
    super.key,
    required TextEditingController empNameController,
    required this.icons,
    required this.hintText,
  }) : _empNameController = empNameController;

  final TextEditingController _empNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _empNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        prefixIcon: Icon(icons),
        hintText: 'Enter $hintText',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
