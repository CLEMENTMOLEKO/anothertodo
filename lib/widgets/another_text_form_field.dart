import 'package:flutter/material.dart';

class AnotherTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool withOutsideLabel;
  final String outsideLabelText;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final VoidCallback? onTap;

  AnotherTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.withOutsideLabel = true,
    this.outsideLabelText = "",
    this.onFieldSubmitted,
    this.readOnly = false,
    this.onTap,
  }) : assert(withOutsideLabel && outsideLabelText.isNotEmpty,
            "outsideLabelText must not be empty if withOutsideLabel is true");

  @override
  State<AnotherTextFormField> createState() => _AnotherTextFormFieldState();
}

class _AnotherTextFormFieldState extends State<AnotherTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.withOutsideLabel)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.outsideLabelText),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TextFormField(
            controller: widget.controller,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              filled: true,
              prefixIcon: Icon(widget.prefixIcon),
              isDense: true,
              fillColor: Colors.grey.withOpacity(0.2),
            ),
            onFieldSubmitted: widget.onFieldSubmitted,
          ),
        ),
      ],
    );
  }
}
