/// Coerces a JSON value to an `int`, whatever the server sent.
///
/// APIs are not consistent about numeric types: the same column can arrive as
/// `2` from one host and `"2"` from another. MySQL over PDO with emulated
/// prepares returns every column as a string, so a backend that types cleanly
/// in development can start handing back quoted numbers once it is deployed to
/// shared hosting. Assigning that straight into an `int?` field throws
/// `type 'String' is not a subtype of type 'int?'` at runtime.
///
/// Returns `null` for null, empty, or unparseable input rather than throwing —
/// a missing count should not take down a whole screen.
int? asInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString().trim());
}

/// [asInt] with a fallback, for fields the UI expects to always hold a number.
int asIntOr(dynamic value, int fallback) => asInt(value) ?? fallback;
