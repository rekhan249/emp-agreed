import 'package:dio/dio.dart';

// Represent exceptions from Server/Remote data source.
class RemoteException implements Exception {
  DioException dioException;

  RemoteException({required this.dioException});
}

// Represent exceptions from Cache.
class LocalException implements Exception {
  String error;

  LocalException(this.error);
}

class RouteException implements Exception {
  final String message;
  RouteException(this.message);
}
