import 'dart:io';

import 'package:flutter/material.dart';

class PlatformHelper {
  static IconData backIcon =
      Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back;
}
