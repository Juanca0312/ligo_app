import 'package:flutter/material.dart';

/// A custom [TextFormField] widget
class LigoTextFormField extends StatefulWidget {
  /// Creates a [LigoTextFormField] widget.
  const LigoTextFormField({
    super.key,
    this.onChanged,
    this.hintText,
    this.obscureText = false,
    this.errorText,
    this.keyboardType,
  });

  /// Callback function that is called when the text in the field changes.
  final void Function(String value)? onChanged;

  /// The hint text to display when the field is empty.
  final String? hintText;

  /// Whether to obscure the text in the field (e.g. for passwords).
  /// Adds a toggle button to show/hide the text when set to true.
  final bool obscureText;

  /// The error text to display when the field is invalid.
  final String? errorText;

  /// The type of keyboard to use for the text field.
  final TextInputType? keyboardType;

  @override
  State<LigoTextFormField> createState() => _LigoTextFormFieldState();
}

class _LigoTextFormFieldState extends State<LigoTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: _isObscured,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        suffixIcon: widget.obscureText
            ? _VisibilityButton(
                isObscured: _isObscured,
                onPressed: _toggleVisibility,
              )
            : null,
      ),
    );
  }
}

class _VisibilityButton extends StatelessWidget {
  const _VisibilityButton({
    required this.isObscured,
    required this.onPressed,
  });

  final bool isObscured;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    icon: Icon(
      isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
    ),
  );
}
