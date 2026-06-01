import 'package:flutter/material.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';

/// A widget that displays a message when there are no movements to show.
class MovementsEmpty extends StatelessWidget {
  /// Creates a new instance of [MovementsEmpty].
  const MovementsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const Icon(Icons.info_outline, size: 64, color: LigoColor.primary),
          const SizedBox(height: LigoSpacing.s),
          Text(
            context.localized.movementsEmpty,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
