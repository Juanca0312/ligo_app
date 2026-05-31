import 'package:flutter/material.dart';

/// A custom button widget for the Ligo app.
class LigoButton extends StatelessWidget {
  /// Creates a [LigoButton] widget.
  const LigoButton({
    required this.onPressed,
    required this.text,
    this.isEnabled = true,
    this.isLoading = false,
    super.key,
  });

  /// Callback function that is called when the button is pressed.
  final void Function() onPressed;

  /// The text to display on the button.
  final String text;

  /// Whether the button is enabled or disabled.
  final bool isEnabled;

  /// Whether the button is in a loading state.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              text,
            ),
    );
  }
}
