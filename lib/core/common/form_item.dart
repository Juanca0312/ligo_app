/// This file defines a generic FormItem class that holds a value and an
/// optional error. It is used to represent the state of form fields in the
/// application, allowing for easy management of both the field's value and
/// its validation error.
class FormItem<T, E> {
  /// Creates a new instance of [FormItem] with the given
  /// [value] and optional [error].
  const FormItem({
    required this.value,
    this.error,
    this.isDirty = false,
  });

  /// The current value of the form item.
  final T value;

  /// The current error associated with the form item, if any.
  final E? error;

  /// Indicates whether the form item has been modified from its initial state.
  final bool isDirty;

  /// Returns true if the form item is valid
  bool get isValid => isDirty && error == null;

  /// Creates a copy of this [FormItem] with the given parameters.
  FormItem<T, E> copyWith({
    T? value,
    E? error,
    bool? isDirty,
  }) {
    return FormItem(
      value: value ?? this.value,
      error: error,
      isDirty: isDirty ?? this.isDirty,
    );
  }
}
