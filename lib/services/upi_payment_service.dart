import 'package:upi_india/upi_india.dart';

class UpiPaymentService {
  final UpiIndia _upiIndia = UpiIndia();

  Future<UpiResponse?> startUpiPayment(double amount) async {
    try {
      final apps = await _upiIndia.getAllUpiApps();

      if (apps.isEmpty) {
        return null;
      }

      final response = await _upiIndia.startTransaction(
        app: apps.first, // you can show list to user also
        receiverUpiId: "ansiyabanupc@okicici", // 🔥 replace with your UPI ID
        receiverName: "Ansiya banu", // 🔥 replace with receiver name
        transactionRefId: DateTime.now().millisecondsSinceEpoch.toString(),
        transactionNote: "Order Payment",
        amount: amount,
      );

      return response;
    } catch (e) {
      return null;
    }
  }
}
