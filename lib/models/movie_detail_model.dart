class MovieDetails {
  final String title;
  final String year;
  final String genre;
  final String  director;
  final String imdbRating;
  final String plot;
  final String? posterUrl;
  final double? rating;

  MovieDetails({
    required this.title, 
    required this.year, 
    required this.genre, 
    required this.director, 
    required this.imdbRating,
    required this.plot,
    this.posterUrl,
    this.rating,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
    title: json['Title'] ?? '',
    year: json['Year'] ?? '',
    genre: json['Genre'] ?? 'N/A',
    director: json['Director'] ?? 'N/A',
    imdbRating: json['imdbRating'] ?? 'N/A',
    plot: json['Plot'] ?? 'No plot available',
    posterUrl: json['Poster'] == 'N/A' ? null : json['Poster'],
    rating: double.tryParse(json['imdbRating']?.replaceAll('\/10', '') ?? '0'),
  );
}
