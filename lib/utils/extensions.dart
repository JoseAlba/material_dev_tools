/// A generic extension for working with Enum types, allowing conversion between
/// integer values and Enum instances.
extension EnumExtension<T extends Enum> on T {
  /// Converts an integer to an Enum instance from a given list of Enum values.
  /// If the integer is out of range, it returns the provided `defaultValue`
  /// or defaults to the first Enum value.
  static T fromInt<T extends Enum>(
    int value,
    List<T> values, {
    T? defaultValue,
  }) {
    return (value >= 0 && value < values.length)
        ? values[value]
        : (defaultValue ?? values.first);
  }

  /// Converts an Enum instance to its corresponding integer index in the given list of values.
  int toInt(List<T> values) {
    return values.indexOf(this);
  }
}
