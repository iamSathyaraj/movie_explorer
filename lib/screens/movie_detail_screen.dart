
import 'package:flutter/material.dart';
import 'package:movie_booking/controller/movie_controller.dart';
import 'package:movie_booking/screens/booking_confirm_screen.dart';
import 'package:movie_booking/controller/booking_controller.dart';
import 'package:provider/provider.dart';

class MovieDetailsView extends StatefulWidget {
  final String imdbId;

  const MovieDetailsView({Key? key, required this.imdbId}) : super(key: key);

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  String? selectedTime;
  DateTime? selectedDate; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieController>().getMovieDetails(widget.imdbId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieController>(
        builder: (context, controller, child) {
          if (controller.isLoading && controller.selectedMovie == null) {
            return Center(child: CircularProgressIndicator());
          }

          final movieDetails = controller.selectedMovie;
          if (movieDetails == null) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Movie details not found'),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Back'),
                    ),
                  ],
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      movieDetails.posterUrl != null
                          ? Image.network(
                              movieDetails.posterUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey[900]),
                            )
                          : Container(color: Colors.grey[900]),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.5, 0.8],
                            colors: [
                              Colors.black87,
                              Colors.black54,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[900]!, Colors.black],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movieDetails.title,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 162, 30, 16),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    movieDetails.genre,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '2h 58m',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          movieDetails.plot,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            height: 1.6,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 30),
                      
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Date & Time',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),
                            
                            GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(Duration(days: 30)),
                                );
                                if (picked != null) {
                                  setState(() {
                                    selectedDate = picked;
                                    selectedTime = null; 
                                  });
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(5),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withAlpha(3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today, 
                                        color: Colors.white70),
                                    SizedBox(width: 12),
                                    Text(
                                      selectedDate == null
                                          ? 'Select Date'
                                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            
                            if (selectedDate != null) ...[
                              Text(
                                'Available Showtimes',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(height: 12),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _customShowtimeButton('08:40', selectedTime == '08:40'),
                                    SizedBox(width: 12),
                                    _customShowtimeButton('09:30', selectedTime == '09:30'),
                                    SizedBox(width: 12),
                                    _customShowtimeButton('10:45', selectedTime == '10:45'),
                                    SizedBox(width: 12),
                                    _customShowtimeButton('12:30', selectedTime == '12:30'),
                                    SizedBox(width: 12),
                                    _customShowtimeButton('14:20', selectedTime == '14:20'),
                                    SizedBox(width: 12),
                                    _customShowtimeButton('16:15', selectedTime == '16:15'),
                                  ],
                                ),
                              ),
                            ] else ...[
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Select date first to see showtimes',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 40),
                      
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 235, 46, 24),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 8,
                          ),
                          onPressed: selectedDate != null && selectedTime != null
                              ? () {
                                  context.read<BookingController>().createBooking(
                                    '${movieDetails.title} • ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                    selectedTime!,
                                  );
                                  
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingConfirmationScreen(),
                                    ),
                                  );
                                }
                              : null,
                          child: Text(
                            selectedDate != null && selectedTime != null
                                ? 'Book Now - ${selectedTime}'
                                : 'Select Date & Time',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _customShowtimeButton(String time, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = time;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.white.withOpacity(0.3),
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
