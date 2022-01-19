import 'dart:developer';
import 'package:flutter/foundation.dart';

void debugLog(String tag, String msg) {
  if (kReleaseMode) {
    return;
  }
  log('$tag : $msg');
}
