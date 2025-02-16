// import 'dart:async';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';
// import 'package:honeywell_scanner/honeywell_scanner.dart';

// //todo:
// /*
// Se debe de cambiar auwi styles para separar el scanner controller
// ya que a como está, lanzará un error al momento de compilar
//  */
// //*Se requieren los siguientes pasos:
// /*
// 1.
// Copy the honeywell folder which is inside the example code sources at:
// .../.pub-cache/hosted/pub.dartlang.org/honeywell_scanner-x.x.x+x/example/android/honeywell
// into your android project module

// 2.
// Add this include ':honeywell' to your settings.gradle

// 3.
// Add tools:replace="android:label" under application tag in your AndroidManifest.xml
// y si es necesario tambien agregar android:allowBackup dentro de la misma etiqueta
//  */
// class ScannerController {
//   static final player = AudioPlayer();
//   static final honeywellScanner = HoneywellScanner();
//   static Future init() async {
//     await honeywellScanner.isSupported().then((value) {
//       if (value) {
//         debugPrint('Scanner is supported');
//         honeywellScanner.startScanner();
//       }
//     });
//     List<CodeFormat> codeFormats = CodeFormatUtils.ALL_1D_FORMATS;
//     // Map<String, dynamic> properties = {
//     //   ...CodeFormatUtils.getAsPropertiesComplement(codeFormats),
//     // };
//     honeywellScanner
//         .setProperties(CodeFormatUtils.getAsPropertiesComplement(codeFormats));
//     //initScan();
//   }

//   static Future<void> initScan() async {
//     debugPrint('Scanner initialized');
//     await honeywellScanner.startScanner();
//     honeywellScanner.onScannerDecodeCallback = (scannedData) {
//       _controller.sink.add(scannedData);
//       debugPrint('Scanned data: ${scannedData?.code.toString()}');
//     };
//     honeywellScanner.onScannerErrorCallback = (error) {
//       _controller.sink.add(errorScan);
//       debugPrint('Error: $error');
//     };
//   }

//   static Future<void> cancelScan() async {
//     debugPrint('Scanner canceled');
//     await honeywellScanner.pauseScanner();
//   }

//   static final StreamController<ScannedData?> _controller =
//       StreamController<ScannedData>.broadcast();

//   static Stream<ScannedData?> get scanListener => _controller.stream;
//   static ScannedData get errorScan => const ScannedData(code: 'Error');

//   static Future playBeep() async {
//     // await player.stop();
//     // await player.play(AssetSource('scanner_beep.mp3'));
//   }
// }
