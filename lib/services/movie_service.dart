import 'dart:convert';

import 'package:movie_booking/core/constants/api_constants.dart';
import 'package:movie_booking/models/movie_detail_model.dart';
import 'package:movie_booking/models/movie_model.dart';
import 'package:http/http.dart'as http;

class MovieService {
final http.Client _client;


  MovieService({http.Client? client}) : _client = client ?? http.Client();

  factory MovieService.create() => MovieService();



  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    try {
      final uri = ApiConstants.searchMoviesUri(query, page: page);
      final response = await _client.get(uri).timeout(ApiConstants.timeout);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['Response'] == 'True') {
          final List<dynamic> results = data['Search'] ?? [];
          return results.map((json) => MovieModel.fromJson(json)).toList();
        }
        throw Exception(data['Error'] ?? 'No movies found');
      }
      throw Exception('HTTP ${response.statusCode}');
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }



    Future<MovieDetails> getMovieDetails(String imdbId) async {
    try {
      final uri = ApiConstants.movieDetailsUri(imdbId);
      final response = await _client.get(uri).timeout(ApiConstants.timeout);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == 'True') {
          return MovieDetails.fromJson(data);     
       }
        throw Exception(data['Error'] ?? 'Movie not found');
      }
      throw Exception('HTTP ${response.statusCode}');
    } catch (e) {
      throw Exception('Details failed: $e');
    }
  }


}