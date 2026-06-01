import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';
import 'package:ligo_app/core/widgets/widgets.dart';
import 'package:ligo_app/features/movements/domain/cubits/movements/movements_cubit.dart';

/// A widget that displays an error message when there is an error
/// loading the movements.
class MovementsError extends StatelessWidget {
  /// Creates a new instance of [MovementsError].
  const MovementsError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LigoSpacing.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 64, color: LigoColor.primary),
          const SizedBox(height: LigoSpacing.s),
          Text(
            context.localized.genericError,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: LigoSpacing.m),
          LigoButton(
            onPressed: () => context.read<MovementsCubit>().loadMovements(),
            text: context.localized.retry,
          ),
        ],
      ),
    );
  }
}
