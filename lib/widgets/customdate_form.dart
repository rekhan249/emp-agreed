import 'package:emp_agreement/providers/date_controller.dart';
import 'package:flutter/material.dart';

class CustomDateFormfield extends StatelessWidget {
  const CustomDateFormfield({
    super.key,
    required TextEditingController startDateControl,
    required this.datePro,
    required this.hintText,
  }) : _startDateControl = startDateControl;

  final TextEditingController _startDateControl;
  final DateProvider datePro;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _startDateControl,
      readOnly: true,
      onTap: () async {
        _startDateControl.text = (await datePro.selectDate(context))!;
      },
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.calendar_today),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
