import 'package:flutter/material.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';

/// A simple data class representing an item in the dropdown menu.
class LigoDropdownMenuItem {
  /// Creates a new instance of [LigoDropdownMenuItem].
  const LigoDropdownMenuItem({
    required this.id,
    required this.label,
  });

  /// The unique identifier of the dropdown item.
  final String id;

  /// The display label of the dropdown item.
  final String label;
}

/// A custom dropdown button widget for the Ligo application.
class LigoDropdownMenu extends StatefulWidget {
  /// Creates a [LigoDropdownMenu] widget.
  const LigoDropdownMenu({
    required this.items,
    this.placeholder = '',
    this.onChanged,
    super.key,
  });

  /// The list of items to be displayed in the dropdown menu.
  final List<LigoDropdownMenuItem> items;

  /// The placeholder text to be shown when no item is selected.
  final String placeholder;

  /// Callback function that is called when an item is selected
  final void Function(LigoDropdownMenuItem? item)? onChanged;

  @override
  State<LigoDropdownMenu> createState() => _LigoDropdownMenuState();
}

class _LigoDropdownMenuState extends State<LigoDropdownMenu> {
  LigoDropdownMenuItem? _selectedItem;
  final TextEditingController _internalController = TextEditingController();

  @override
  void dispose() {
    _internalController.dispose();
    super.dispose();
  }

  void _onItemSelected(String? id) {
    if (id == null) return;

    final selectedItem = widget.items.firstWhere(
      (item) => item.id == id,
    );

    setState(() {
      _selectedItem = selectedItem;
    });

    widget.onChanged?.call(selectedItem);
  }

  void _clearSelection() {
    setState(() {
      _selectedItem = null;
      _internalController.clear();
    });

    widget.onChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<String>(
          controller: _internalController,
          width: constraints.maxWidth,
          label: Text(
            widget.placeholder,
            style: const TextStyle(color: LigoColor.textSecondary),
          ),
          trailingIcon: _selectedItem != null
              ? InkWell(
                  onTap: _clearSelection,
                  child: const Icon(Icons.close_rounded),
                )
              : const Icon(Icons.keyboard_arrow_down_rounded),
          selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
          dropdownMenuEntries: widget.items.map((item) {
            return DropdownMenuEntry<String>(
              value: item.id,
              label: item.label,
              labelWidget: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onSelected: _onItemSelected,
        );
      },
    );
  }
}
