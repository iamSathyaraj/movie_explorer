import 'package:flutter/material.dart';
import 'package:movie_booking/controller/movie_controller.dart';
import 'package:movie_booking/screens/movie_detail_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      context.read<MovieController>().loadMoreMovies();
    }
  }

  void _onSearch(String query) {
    if (query.trim().isNotEmpty) {
      context.read<MovieController>().searchMovie(query.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Explorer'),
        backgroundColor: const Color.fromARGB(255, 173, 36, 15),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<MovieController>().searchMovie('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onSubmitted: _onSearch,
            ),
          ),
          
          Expanded(
            child: Consumer<MovieController>(
              builder: (context, controller, child) {
                if (controller.isLoading && controller.movies.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text('Error: ${controller.error}'),
                        ElevatedButton(
                          onPressed: () => _onSearch(_searchController.text),
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.movies.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.movie_outlined, size: 80),
                        SizedBox(height: 16),
                        Text('Search for movies', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.all(16),
                  itemCount: controller.movies.length + (controller.isLoadingMore ? 1 : 0),
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == controller.movies.length) {
                      return Center(child: CircularProgressIndicator());
                    }
                    
                    final movie = controller.movies[index];
                    return MovieCard(movie: movie,onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailsView(imdbId: movie.imdbId)));
                    },);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
