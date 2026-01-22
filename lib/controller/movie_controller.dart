import 'package:flutter/material.dart';
import 'package:movie_booking/models/movie_detail_model.dart';
import 'package:movie_booking/models/movie_model.dart';
import 'package:movie_booking/services/movie_service.dart';

class MovieController extends ChangeNotifier{
  List <MovieModel> _movies=[];
  MovieDetails? _selectedMovie;
bool _isLoading= false;
bool _isLoadingMore = false;
String? _error;
String _currentQuery = '';

List <MovieModel> get movies =>_movies;
MovieDetails? get selectedMovie=>_selectedMovie;
bool get isLoading=>_isLoading;
  bool get isLoadingMore => _isLoadingMore;

String? get error => _error;
  String get currentQuery => _currentQuery;




MovieService movieService = MovieService();

  Future<void>searchMovie(String query)async{
if(query.trim().isEmpty){
  return ;
}
 _currentQuery = query.trim();
_isLoading = true;
_error = null;
notifyListeners();

  try {
      final newMovies = await movieService.searchMovies(query);
      _movies = newMovies;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
Future<void> loadMoreMovies() async {
    if (_isLoadingMore || _currentQuery.isEmpty) return;  

    _isLoadingMore = true;
    notifyListeners();

    try {
      final page = (_movies.length ~/ 10) + 1;
      final newMovies = await movieService.searchMovies(_currentQuery, page: page);
      
      if (newMovies.isNotEmpty) {
        _movies.addAll(newMovies);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> getMovieDetails(String imdbId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedMovie = await movieService.getMovieDetails(imdbId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  

}