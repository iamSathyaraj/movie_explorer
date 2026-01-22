class MovieModel {
 
  final String title;
  final String year;
  final String? poster;
  final String imdbId;

  MovieModel({
    required this.title,
    required this.year,
     this.poster,
    required this.imdbId
  });

  factory MovieModel.fromJson(Map <String, dynamic>json){
    return MovieModel(
      title: json['Title'] ?? '',
    year: json['Year'] ?? '',
    poster: json['Poster'] == 'N/A' ? null : json['Poster'],
    imdbId: json['imdbID'],

    );
  }

}