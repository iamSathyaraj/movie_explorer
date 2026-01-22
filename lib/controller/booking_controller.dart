import 'package:flutter/material.dart';

class BookingController extends ChangeNotifier {
  String? _selectedMovieTitle;
  String? _selectedTime;
  String? _ticketId;

  String? get selectedMovieTitle => _selectedMovieTitle;
  String? get selectedTime => _selectedTime;
  String? get ticketId => _ticketId;
  bool get hasBooking => _ticketId != null;

  void createBooking(String movieTitle, String time) {
    _selectedMovieTitle = movieTitle;
    _selectedTime = time;
    _ticketId = 'MOV${DateTime.now().millisecondsSinceEpoch}';
    notifyListeners();
  }

  void clearBooking() {
    _selectedMovieTitle = null;
    _selectedTime = null;
    _ticketId = null;
    notifyListeners();
  }
}
