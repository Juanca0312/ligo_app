import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';
import 'package:ligo_app/core/widgets/widgets.dart';
import 'package:ligo_app/features/movements/domain/cubits/movements/movements_cubit.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_filter.dart';
import 'package:ligo_app/features/movements/presentation/widgets/widgets.dart';

/// A page that displays the movements of the user.
class MovementsPage extends StatefulWidget {
  /// Creates a new instance of [MovementsPage].
  const MovementsPage({super.key});

  @override
  State<MovementsPage> createState() => _MovementsPageState();
}

class _MovementsPageState extends State<MovementsPage> {
  @override
  void initState() {
    unawaited(context.read<MovementsCubit>().loadMovements());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LigoAppBar(
        title: context.localized.movements,
        onLogout: () {},
      ),
      body: const _MovementsView(),
    );
  }
}

class _MovementsView extends StatelessWidget {
  const _MovementsView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: LigoSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),
            _MovementFilterDropdown(),
            SizedBox(height: LigoSpacing.m),
            Expanded(
              child: _MovementList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovementFilterDropdown extends StatelessWidget {
  const _MovementFilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return LigoDropdownButton(
      placeholder: context.localized.filterByStatusType,
      items: MovementFilterItem.values
          .map(
            (item) => LigoDropdownMenuItem(
              id: item.toString(),
              label: item.localized(context),
            ),
          )
          .toList(),
      onChanged: (item) {},
    );
  }
}

class _MovementList extends StatelessWidget {
  const _MovementList({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<MovementsCubit>().loadMovements();
      },
      child: BlocBuilder<MovementsCubit, MovementsState>(
        buildWhen: (previous, current) =>
            previous.movements != current.movements ||
            previous.requestStatus != current.requestStatus,
        builder: (context, state) {
          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.movements.length,
            itemBuilder: (context, index) {
              final movement = state.movements[index];
              return MovementTile(
                movement: movement,
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                color: LigoColor.border,
              );
            },
          );
        },
      ),
    );
  }
}
