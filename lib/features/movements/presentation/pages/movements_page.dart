import 'package:flutter/material.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';

/// A page that displays the movements of the user.
class MovementsPage extends StatelessWidget {
  /// Creates a new instance of [MovementsPage].
  const MovementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movements'),
      ),
      body: Center(
        child: Text(context.localized.movements),
      ),
    );
  }
}
