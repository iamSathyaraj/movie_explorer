class ApiConstants {
  static const String baseUrl = 'http://www.omdbapi.com';
  static const String apiKey = '9aeae9e8'; 

static Uri searchMoviesUri(String query, {int page = 1}) {
    return Uri.parse(
      '$baseUrl/?apikey=$apiKey&s=${Uri.encodeComponent(query)}&page=$page'
    );
  }
  
  static Uri movieDetailsUri(String imdbId, {String plot = 'full'}) {
    return Uri.parse(
      '$baseUrl/?apikey=$apiKey&i=$imdbId&plot=$plot'
    );
  }

    static const Duration timeout = Duration(seconds: 15);

  }
