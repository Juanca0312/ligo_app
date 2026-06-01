import 'package:flutter/material.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/presentation/widgets/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A skeleton widget that mimics the appearance of a list of movements
class MovementsSkeletonList extends StatelessWidget {
  /// Creates a new instance of [MovementsSkeletonList]
  const MovementsSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (_, _) => MovementTile(
          movement: Movement.skeleton(),
          onTap: () {},
        ),
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: LigoColor.border),
      ),
    );
  }
}
