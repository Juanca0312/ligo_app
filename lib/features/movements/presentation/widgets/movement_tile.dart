import 'package:flutter/material.dart';
import 'package:ligo_app/core/extensions/text_theme_extension.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_status.dart';

/// A widget that displays a movement in a list tile format.
class MovementTile extends StatelessWidget {
  /// Creates a new instance of [MovementTile]
  const MovementTile({required this.movement, required this.onTap, super.key});

  /// The movement to be displayed in the tile.
  final Movement movement;

  /// Callback function to be executed when the tile is tapped.
  final VoidCallback onTap;

  Color get _amountColor {
    final baseColor = _isOutcome ? LigoColor.error : LigoColor.success;

    if (_isPending) {
      return baseColor.withAlpha(_isOutcome ? 150 : 85);
    }

    return baseColor;
  }

  Color get _descriptionColor {
    return switch (movement.status) {
      MovementStatus.completed => LigoColor.textPrimary,
      MovementStatus.failed => LigoColor.error,
      _ => LigoColor.textSecondary,
    };
  }

  bool get _isPending => movement.status == .pending;
  bool get _isOutcome => movement.type == .outcome;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movement.description,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: _descriptionColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: LigoSpacing.xs),
                  Text(
                    movement.status.localized(context),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: _descriptionColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              movement.amountFormatted,
              style: context.textTheme.bodyMedium?.copyWith(
                color: _amountColor,
              ),
              textAlign: TextAlign.end,
            ),
            const SizedBox(width: LigoSpacing.m),
            const Icon(
              Icons.chevron_right,
              color: LigoColor.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
