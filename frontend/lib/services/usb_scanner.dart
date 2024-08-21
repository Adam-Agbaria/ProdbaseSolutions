// import 'dart:async';
// import 'dart:typed_data';
// import 'package:usb_serial/transaction.dart';
// import 'package:usb_serial/usb_serial.dart';
// import '../utils/validators.dart';

// class UsbSerialScanner {
//   UsbPort? port;
//   UsbDevice? device;
//   Transaction<String>? transaction;
//   final StreamController<String> _barcodeStreamController =
//       StreamController<String>.broadcast();

//   Stream<String> get barcodeStream => _barcodeStreamController.stream;

//   UsbSerialScanner() {
//     _init();
//   }

//   _init() async {
//     final devices = await UsbSerial.listDevices();
//     this.device = devices.first;
//     final barcodeHandler = BarcodeValidators();

//     if (device != null) {
//       device!.create();
//       print("Device connected: ${device!.productName}");

//       port = await device!.create();
//       bool openResult = await port!.open();
//       if (!openResult) {
//         print("Could not open port");
//         return;
//       }

//       port!.setDTR(true);
//       port!.setRTS(true);

//       if (port!.inputStream != null) {
//         transaction = Transaction.stringTerminated(
//             port!.inputStream!, Uint8List.fromList([13, 10]));

//         transaction!.stream.listen((String line) {
//           print("Received: $line");
//           _barcodeStreamController.add(line);
//           transaction!.stream.listen((String line) {
//             print("Received: $line");

//             // Use the BarcodeHandler instance to validate and handle the barcode
//             barcodeHandler.handleScannedBarcode(line);

//             // If you reach this point, the barcode passed all validations
//             // and was successfully handled
//             _barcodeStreamController.add(line);
//           });
//         });
//       }
//     }
//   }
// }
