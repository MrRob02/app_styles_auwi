import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../Herramientas/colores.dart';
import '../Herramientas/vibrator_helper.dart';

class BotonEscaneo extends StatefulWidget {
  final RxBool isTorchEnabled;
  final MobileScannerController controller;
  final void Function()? onEmulator;
  const BotonEscaneo(
      {super.key,
      required this.isTorchEnabled,
      required this.controller,
      required this.onEmulator});

  @override
  State<BotonEscaneo> createState() => _BotonEscaneoState();
}

class _BotonEscaneoState extends State<BotonEscaneo>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _animationIcon;
  late Animation<Color?> _animationColor;
  late Animation<Color?> _animationOppositeColor;
  final tiempoAnimacion = 300;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: tiempoAnimacion),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _animation =
        Tween<double>(begin: 70, end: 100).animate(_animationController);
    _animationIcon =
        Tween(begin: 40.0, end: 60.0).animate(_animationController);
    _animationOppositeColor = ColorTween(
      begin: Colores.grisPrimario,
      end: Colors.white,
    ).animate(_animationController);
    _animationColor = ColorTween(
      begin: Colors.white,
      end: Colores.grisPrimario,
    ).animate(_animationController);
    clicking.listen((p0) {
      if (p0) {
        widget.controller.start();
        Future.delayed(const Duration(milliseconds: 200), () {
          if (widget.controller.torchEnabled != widget.isTorchEnabled.value) {
            widget.controller.toggleTorch();
          }
        });
      } else {
        widget.controller.stop();
        locked.value = false;
      }
    });
  }

  Offset? buttonPosition;
  double? dragPosition;
  final clicking = false.obs;
  final locked = false.obs;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final color = _animationColor.value;
      final oppositeColor = _animationOppositeColor.value;
      double height = _animation.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!clicking.value)
            const Text(
              'Manten presionado para escanear',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          const Gap(10),
          Stack(
            children: [
              SizedBox(
                height: height,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      widget.isTorchEnabled.toggle();
                      widget.controller.toggleTorch();
                    },
                    icon: Icon(widget.isTorchEnabled.value
                        ? Icons.flash_on
                        : Icons.flash_off),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Listener(
                  onPointerDown: (details) {
                    _animationController.forward();
                    VibratorHelper.vibrate();
                    timer = Timer(Duration(milliseconds: tiempoAnimacion),
                        () async {
                      final value = await _isEmulator();
                      if (kDebugMode && value) {
                        if (value) {
                          widget.onEmulator?.call();
                          _animationController.reverse();
                        }
                      } else {
                        clicking.value = true;
                      }
                    });
                  },
                  onPointerUp: (details) {
                    timer?.cancel();
                    _animationController.reverse();
                    clicking.value = false;
                  },
                  onPointerCancel: (details) {
                    timer?.cancel();
                    _animationController.reverse();
                    clicking.value = false;
                  },
                  child: Container(
                    height: height,
                    width: height,
                    decoration: const BoxDecoration(
                        color: Colores.grisPrimario, shape: BoxShape.circle),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: color,
                          surfaceTintColor: color,
                          shape: const CircleBorder(),
                          child: Center(
                            child: Icon(
                              Icons.qr_code_scanner,
                              color: oppositeColor,
                              size: _animationIcon.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }

  Future<bool> _isEmulator() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return !androidInfo.isPhysicalDevice;
  }
}
