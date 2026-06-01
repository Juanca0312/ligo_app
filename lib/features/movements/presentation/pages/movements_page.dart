import 'package:flutter/material.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';
import 'package:ligo_app/core/widgets/widgets.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_filter.dart';
import 'package:ligo_app/features/movements/presentation/widgets/widgets.dart';

/// A page that displays the movements of the user.
class MovementsPage extends StatelessWidget {
  /// Creates a new instance of [MovementsPage].
  const MovementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LigoAppBar(
        title: context.localized.movements,
        onLogout: () {},
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LigoSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              LigoDropdownButton(
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
              ),
              const SizedBox(height: LigoSpacing.m),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: Builder(
                    builder: (context) {
                      return ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          final movement = Movement(
                            id: index.toString(),
                            description: 'Movement $index',
                            amount: (index + 1) * 10.0,
                            type: index.isEven ? .income : .outcome,
                            status: index.isEven ? .completed : .pending,
                          );
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
