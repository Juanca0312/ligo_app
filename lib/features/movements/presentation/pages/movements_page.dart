import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';
import 'package:ligo_app/core/widgets/widgets.dart';
import 'package:ligo_app/features/auth/domain/cubits/session/session_cubit.dart';
import 'package:ligo_app/features/auth/presentation/routes/auth_routes.dart';
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
        onLogout: () {
          unawaited(context.read<SessionCubit>().logout());
          context.goNamed(AuthRoutes.login.name);
        },
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
  const _MovementFilterDropdown();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LigoTextFormField(
          leadingIcon: const Icon(Icons.search),
          onChanged: (value) =>
              context.read<MovementsCubit>().updateQuery(value),
        ),
        const SizedBox(height: LigoSpacing.s),
        LigoDropdownMenu(
          placeholder: context.localized.filterByStatusType,
          items: MovementFilterItem.values
              .map(
                (item) => LigoDropdownMenuItem(
                  id: item.toString(),
                  label: item.localized(context),
                ),
              )
              .toList(),
          onChanged: (item) => _onFilterChanged(context, item),
        ),
      ],
    );
  }

  void _onFilterChanged(BuildContext context, LigoDropdownMenuItem? item) {
    final filterItem = item == null
        ? null
        : MovementFilterItem.values.firstWhere(
            (filter) => filter.toString() == item.id,
          );
    context.read<MovementsCubit>().updateFilter(filterItem);
  }
}

class _MovementList extends StatelessWidget {
  const _MovementList();

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
          if (state.isLoading) {
            return const MovementsSkeletonList();
          }
          if (state.isEmpty) {
            return const MovementsEmpty();
          }
          return ListView.separated(
            itemCount: state.movements.length,
            itemBuilder: (context, index) {
              final movement = state.movements[index];
              return MovementTile(
                movement: movement,
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: LigoColor.border,
            ),
          );
        },
      ),
    );
  }
}
