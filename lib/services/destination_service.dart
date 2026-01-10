import 'dart:convert';

import 'package:dio/dio.dart';

class Destination {
  Destination({
    required this.id,
    required this.name,
    this.shortDescription,
    this.description,
    this.district,
    this.province,
    this.locationString,
    this.type,
    this.category,
    this.averageRating,
  });

  final int id;
  final String name;
  final String? shortDescription;
  final String? description;
  final String? district;
  final String? province;
  final String? locationString;
  final String? type;
  final String? category;
  final double? averageRating;

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? 'Unknown destination',
      shortDescription: json['shortDescription'] as String?,
      description: json['description'] as String?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      locationString: json['locationString'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
    );
  }

  String get subtitle {
    if (locationString != null && locationString!.trim().isNotEmpty) {
      return locationString!;
    }
    final parts = [
      if (district != null && district!.trim().isNotEmpty) district,
      if (province != null && province!.trim().isNotEmpty) province,
    ];
    if (parts.isNotEmpty) {
      return parts.join(', ');
    }
    return 'Details coming soon';
  }
}

class DestinationFetchException implements Exception {
  const DestinationFetchException(this.message);
  final String message;

  @override
  String toString() => 'DestinationFetchException: $message';
}

class DestinationService {
  DestinationService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  final Dio _dio;
  static const _endpoint =
      'https://zebralike-inquirable-almeda.ngrok-free.dev/api/destinations?page=0&size=20&sortBy=name&sortDirection=ASC';

  Future<List<Destination>> fetchDestinations() async {
    try {
      final response =
          await _dio.get(_endpoint, options: Options(responseType: ResponseType.json));
      final parsed = _parseJson(response.data);
      final content = parsed['content'];
      if (content is List) {
        return content
            .map((item) => Destination.fromJson(
                  Map<String, dynamic>.from(item as Map),
                ))
            .toList();
      }
      throw const DestinationFetchException('Unexpected response shape');
    } on DioException catch (error) {
      final message = error.message ?? 'Unable to reach destinations endpoint';
      throw DestinationFetchException(message);
    } catch (error) {
      throw DestinationFetchException(
        error is DestinationFetchException
            ? error.message
            : 'Failed to load destinations',
      );
    }
  }

  Map<String, dynamic> _parseJson(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is String) {
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) return decoded;
    }
    throw const DestinationFetchException('Invalid response from server');
  }
}
