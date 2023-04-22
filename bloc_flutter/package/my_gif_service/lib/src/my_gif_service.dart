import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
/// {@template my_gif_service}
/// My gif Service
/// {@endtemplate}
class MyGifService {
  /// {@macro my_gif_service}
  MyGifService({http.Client? httpClient})
  : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final String baseUrl = "api.giphy.com";
  final String endPoint = '/v1/gifs/trending';
  final String apiKey = 'bwoKv1V9tw3dXIqd0EmBE7FTR5fYf4yr';

  Future<List<String>> fetchGifs() async {
    final uri = Uri.http(baseUrl,endPoint, {'api_key':apiKey});

    http.Response response;
    List body;

    try{
      response = await _httpClient.get(uri);
    }on Exception{
      throw Exception();
    }
    if (response.statusCode != 200){
      throw HttpRequestException();
    }
    try{
    body = jsonDecode(response.body)['data'] as List;
    }on Exception{
      throw JsonDecodeException();
    }
    return body
    .map((url) => url['images']['original']['url'].toString()).toList();
  }
}

class HttpRequestException implements Exception{}
class JsonDecodeException implements Exception{}



