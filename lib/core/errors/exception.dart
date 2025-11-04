/// Exception handling utilities for network and application errors.
///
/// Defines base and specialized exception classes for representing
/// server-side, user-side, and general application errors. Also provides
/// a helper to convert Dio exceptions into app-specific exceptions for
/// consistent error handling across the app.
library;

import 'package:dio/dio.dart';

/// Base exception for all app-specific errors.
///
/// [statusCode] is optional and typically used for HTTP/network errors.
/// [message] provides a human-readable description of the error.
class AppException implements Exception {
  final int? statusCode;
  final String message;

  AppException({this.statusCode, required this.message});

  @override
  String toString() {
    return 'AppException(statusCode: $statusCode, message: $message)';
  }
}

/// Exception for server-side errors (5xx or unexpected backend issues).
final class ServerException extends AppException {
  ServerException({super.statusCode, required super.message});
}

/// Exception for user-side or client errors (4xx or user actions).
final class UserException extends AppException {
  UserException({super.statusCode, required super.message});
}

/// Maps Dio network exceptions to app-specific exception types.
///
/// Converts Dio's [DioException] into [UserException], [ServerException],
/// or [AppException] for consistent error handling in the app's UI and logic.
AppException handleDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionError:
      // Network is unreachable or server is down
      return ServerException(
        statusCode: 503,
        message:
            error.response?.data['error']['message'] ??
            'Connection error occurred',
      );

    case DioExceptionType.connectionTimeout:
      // Connection could not be established in time
      return UserException(
        statusCode: 408,
        message:
            error.response?.data['error']['message'] ?? 'Connection timed out',
      );

    case DioExceptionType.sendTimeout:
      // Request was not sent in time
      return UserException(
        statusCode: 408,
        message:
            error.response?.data['error']['message'] ?? 'Request timed out',
      );

    case DioExceptionType.receiveTimeout:
      // Response was not received in time
      return UserException(
        statusCode: 408,
        message:
            error.response?.data['error']['message'] ?? 'Response timed out',
      );

    case DioExceptionType.cancel:
      // Request was cancelled by the user or app
      return UserException(
        statusCode: 499,
        message:
            error.response?.data['error']['message'] ?? 'Request was cancelled',
      );

    case DioExceptionType.badCertificate:
      // SSL certificate error
      return UserException(
        statusCode: 400,
        message:
            error.response?.data['error']['message'] ?? 'Bad certificate error',
      );

    case DioExceptionType.badResponse:
      // Server responded with a non-2xx status code
      switch (error.response?.statusCode) {
        case 400:
          return UserException(
            statusCode: 400,
            message: error.response?.data['error']['message'] ?? 'Bad request',
          );
        case 401:
          return UserException(
            statusCode: 401,
            message:
                error.response?.data['error']['message'] ??
                'Unauthorized access',
          );
        case 403:
          return UserException(
            statusCode: 403,
            message:
                error.response?.data['error']['message'] ?? 'Forbidden access',
          );
        case 404:
          return UserException(
            statusCode: 404,
            message:
                error.response?.data['error']['message'] ??
                'Resource not found',
          );
        case 429:
          return UserException(
            statusCode: 429,
            message:
                error.response?.data['error']['message'] ??
                'Too many requests, please try again later',
          );
        case 500:
          return ServerException(
            statusCode: 500,
            message:
                error.response?.data['error']['message'] ??
                'Internal server error',
          );
        case 502:
          return ServerException(
            statusCode: 502,
            message: error.response?.data['error']['message'] ?? 'Bad gateway',
          );
        case 503:
          return ServerException(
            statusCode: 503,
            message:
                error.response?.data['error']['message'] ??
                'Service unavailable',
          );
        case 504:
          return ServerException(
            statusCode: 504,
            message:
                error.response?.data['error']['message'] ?? 'Gateway timeout',
          );
        default:
          // Any other server error
          return ServerException(
            statusCode: error.response?.statusCode,
            message:
                error.response?.data['error']['message'] ??
                'Bad response from server',
          );
      }

    case DioExceptionType.unknown:
      // Any other unknown error
      return AppException(
        statusCode: error.response?.statusCode,
        message: 'An unknown error occurred',
      );
  }
}
