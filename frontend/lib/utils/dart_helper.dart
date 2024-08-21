import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jiffy/jiffy.dart';

class DartHelper {
  /// Formats a DateTime object to a readable string.
  static String formatDate(dynamic date,
      [String format = 'MMMM do yyyy, h:mm:ss a']) {
    if (date is DateTime) {
      return Jiffy.now().format(pattern: format);
    } else if (date is String) {
      return Jiffy.parse(date).format(pattern: format);
    } else {
      throw ArgumentError(
          'The provided date must be either a DateTime object or a String.');
    }
  }

  /// Checks if the device is currently online.
  static Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  /// Opens a file picker and returns the selected file's path.
  static Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result.files.single.path;
    } else {
      // User canceled the picker
      return null;
    }
  }

  // Add more helper methods as required.
}
