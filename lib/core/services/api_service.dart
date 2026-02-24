import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';
import '../network/api_client.dart';

/// Service centralisé pour gérer tous les appels API
class ApiService {
  late Dio _dio;
  final StorageService _storageService;

  ApiService({required StorageService storageService})
      : _storageService = storageService {
    ApiClient.init(_storageService);
    _dio = ApiClient.createDio();
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    String message;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Délai de connexion dépassé';
        break;
      case DioExceptionType.badResponse:
        message = 'Erreur serveur';
        if (error.response?.data != null) {
          try {
            final data = error.response?.data;
            if (data is Map && data.containsKey('message')) {
              message = data['message'];
            }
          } catch (_) {}
        }
        break;
      case DioExceptionType.cancel:
        message = 'Requête annulée';
        break;
      default:
        message = 'Erreur de connexion';
    }

    return Exception(message);
  }
}