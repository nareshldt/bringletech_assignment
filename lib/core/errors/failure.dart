/// Represents a failure or error state in the app's business logic or use cases.
///
/// Used to encapsulate error information (such as from repositories, services, or use cases)
/// in a way that can be handled by the UI or higher layers. This is not an Exception,
/// but a value object for error reporting and display.
class Failure {
  /// Optional status code (e.g., HTTP status or custom error code).
  final int? statusCode;

  /// Human-readable error message describing the failure.
  final String message;

  Failure({this.statusCode, required this.message});

  @override
  String toString() {
    // Returns a string representation for logging/debugging.
    return 'Failure(statusCode: $statusCode, message: $message)';
  }
}
