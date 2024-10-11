import 'package:auwi_styles/Camera/boton_escanear.dart';
import 'package:auwi_styles/Herramientas/camera_permission.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerSimple extends StatefulWidget {
  final List<Widget> children;
  final Function(BarcodeCapture) handleBarcode;
  final Barcode? barcode;
  final AppBar? appBar;
  final MobileScannerController controller;
  final RxBool? enabled;
  final RxBool isTorchEnabled;
  final void Function()? onEmulator;
  const BarcodeScannerSimple(
      {super.key,
      required this.children,
      required this.handleBarcode,
      required this.controller,
      this.enabled,
      this.appBar,
      this.barcode,
      this.onEmulator,
      required this.isTorchEnabled});

  @override
  State<BarcodeScannerSimple> createState() => _BarcodeScannerSimpleState();
}

class _BarcodeScannerSimpleState extends State<BarcodeScannerSimple> {
  final CameraPermission camera = Get.find();
  @override
  void dispose() {
    widget.controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.appBar,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: MobileScanner(
                onDetect: widget.handleBarcode,
                controller: widget.controller,
              ),
            ),
            ...widget.children,
            Positioned(
                bottom: 70,
                left: 20,
                right: 20,
                child: BotonEscaneo(
                  isTorchEnabled: widget.isTorchEnabled,
                  controller: widget.controller,
                  onEmulator: widget.onEmulator,
                )),
            Obx(() {
              if (!camera.isGranted) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black87,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 15,
                        left: 15,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: IconButton(
                              onPressed: Get.back,
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.black)),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Permisos de cámara',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          const Icon(Icons.camera_alt,
                              color: Colors.white, size: 80),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Para poder escanear códigos de barras necesitamos que nos des permiso para acceder a la cámara',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await CameraPermission.requestCameraPermission();
                            },
                            child: Text(camera.isPermanentDenied
                                ? 'Abrir ajustes'
                                : 'Conceder permiso'),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
