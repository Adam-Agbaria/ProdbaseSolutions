// notification_middleware.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationMiddleware {
  // Function to send an email
  // In a real-world scenario, you might integrate with an email service like SendGrid.
  // Function to send an email using SendGrid
  final String sendGridApiKey; // Your SendGrid API key
  NotificationMiddleware(this.sendGridApiKey);

  Future<void> sendEmail(
      String recipientEmail, String subject, String body) async {
    final url = Uri.parse('https://api.sendgrid.com/v3/mail/send');

    final headers = {
      'Authorization': 'Bearer $sendGridApiKey',
      'Content-Type': 'application/json',
    };

    final data = {
      'personalizations': [
        {
          'to': [
            {'email': recipientEmail}
          ],
          'subject': subject,
        }
      ],
      'from': {'email': 'your@example.com'},
      'content': [
        {'type': 'text/plain', 'value': body}
      ],
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode != 202) {
        throw Exception('Failed to send email');
      }
    } catch (e) {
      print('Error sending email: $e');
      rethrow; // Rethrow the exception to allow the caller to handle it
    }
  }

  // Function to send a push notification
  // In a real-world scenario, you might integrate with a service like Firebase Cloud Messaging.
  Future<void> sendPushNotification(
      String recipientToken, String title, String message) async {
    // Mock implementation
    print(
        "Sending push notification to token $recipientToken with title: $title and message: $message");
    // Here, integrate with your push notification provider and send the notification.
  }

  // Function to send an SMS
  // In a real-world scenario, you might integrate with an SMS gateway like Twilio.
  Future<void> sendSMS(String recipientNumber, String message) async {
    // Mock implementation
    print("Sending SMS to $recipientNumber with message: $message");
    // Here, integrate with your SMS gateway and send the SMS.
  }
}
