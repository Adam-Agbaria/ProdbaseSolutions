// persistence_middleware.dart

import 'dart:io';
import 'dart:convert';

class PersistenceMiddleware {
  final String storagePath;

  PersistenceMiddleware(this.storagePath);

  // Save data to the local storage
  Future<void> saveData(Map<String, dynamic> data) async {
    final file = File(storagePath);
    await file.writeAsString(jsonEncode(data));
  }

  // Retrieve data from the local storage
  Future<Map<String, dynamic>?> retrieveData() async {
    final file = File(storagePath);

    if (await file.exists()) {
      String rawData = await file.readAsString();
      return jsonDecode(rawData);
    }

    return null; // Returns null if no data exists
  }
}
