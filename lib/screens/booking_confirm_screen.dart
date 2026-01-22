
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../controller/booking_controller.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<BookingController>(
          builder: (context, booking, _) {

            if (booking.selectedMovieTitle == null ||
                booking.selectedTime == null ||
                booking.ticketId == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 50,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Booking Successful!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "For ${booking.selectedMovieTitle}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(15),
                          blurRadius: 25,
                          offset: const Offset(0, 12),
                        )
                      ],
                    ),
                    child: Column(
                      children: [

                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                          child: Image.network(

                                "",
                            height: 260,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          booking.selectedMovieTitle!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 6),

                        Text(
                          booking.selectedTime!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              _InfoItem(title: "Date", value: "Apr 23"),
                              _InfoItem(title: "Time", value: "6:00 PM"),
                              _InfoItem(title: "Seats", value: "9,10"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: booking.ticketId!,
                          width: 220,
                          height: 70,
                          drawText: false,
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        context.read<BookingController>().clearBooking();
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text(
                        "Back to Home",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
