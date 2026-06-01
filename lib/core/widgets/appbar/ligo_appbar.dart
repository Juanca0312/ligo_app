import 'package:flutter/material.dart';

/// A custom app bar widget for the Ligo application.
class LigoAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [LigoAppBar] widget.
  const LigoAppBar({
    required this.title,
    this.onBack,
    this.onLogout,
    super.key,
  });

  /// The title to be displayed in the app bar.
  final String title;

  /// An optional callback that is called when the back button is pressed.
  final VoidCallback? onBack;

  /// An optional callback that is called when the logout button is pressed.
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      actions: [
        if (onLogout != null)
          IconButton(icon: const Icon(Icons.logout), onPressed: onLogout),
      ],
      centerTitle: false,
      leading: onBack != null
          ? IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.chevron_left),
              onPressed: onBack,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
