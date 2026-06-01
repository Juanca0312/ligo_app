import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ligo_app/core/common/ligo_assets.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';
import 'package:ligo_app/core/presentation/widgets/widgets.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_status.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_type.dart';
import 'package:ligo_app/features/movements/presentation/cubits/movements/movements_cubit.dart';

/// Page that displays the details of a movement.
class MovementDetailPage extends StatelessWidget {
  /// Creates a new instance of [MovementDetailPage].
  const MovementDetailPage({
    required this.movementId,
    super.key,
  });

  /// Movement id coming from router
  final String movementId;

  @override
  Widget build(BuildContext context) {
    final movement = context.read<MovementsCubit>().getById(movementId);
    return Scaffold(
      backgroundColor: LigoColor.primary,
      appBar: LigoAppBar(
        title: movement.id,
        onBack: () => context.pop(),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(LigoSpacing.l),
            child: _MovementCard(movement: movement),
          ),
        ),
      ),
    );
  }
}

class _MovementCard extends StatelessWidget {
  const _MovementCard({required this.movement});

  final Movement movement;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(LigoSpacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(LigoAssets.logo, width: 80),
            const SizedBox(height: LigoSpacing.m),
            Text(
              movement.description,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LigoSpacing.m),

            _InfoRow(label: context.localized.id, value: movement.id),
            _InfoRow(
              label: context.localized.amount,
              value: '${movement.amount}',
            ),
            _InfoRow(
              label: context.localized.type,
              value: movement.type.localized(context),
            ),
            _InfoRow(
              label: context.localized.status,
              value: movement.status.localized(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
