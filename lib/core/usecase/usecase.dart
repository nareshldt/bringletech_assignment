import 'package:fpdart/fpdart.dart';

import '../errors/failure.dart';

/// Base interface for all use cases in the application (business logic actions).
///
/// [SuccessType] is the type returned on success, [Params] is the input parameter type.
/// Usecases encapsulate a single action or business rule, and are typically called from
/// Bloc, Cubit, or other presentation logic. All usecases return an [Either] with a [Failure]
/// on the left (error) and [SuccessType] on the right (success).
///
/// Example:
/// ```dart
/// class Login implements Usecase<AppUser, LoginParams> { ... }
/// ```
abstract interface class Usecase<SuccessType, Params> {
  /// Executes the usecase with the given [params].
  /// Returns [Either] with [Failure] on error or [SuccessType] on success.
  Future<Either<Failure, SuccessType>> call(Params params);
}

/// Empty parameter class for usecases that do not require any input.
///
/// Use this when a usecase does not need parameters:
/// ```dart
/// class GetVersion implements Usecase<String, NoParams> { ... }
/// ```
class NoParams {}
