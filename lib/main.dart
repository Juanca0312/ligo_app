import 'package:flutter/material.dart';
import 'package:ligo_app/core/di/service_locator.dart';
import 'package:ligo_app/ligo_app.dart';

void main() {
  setupDependencies();
  runApp(const LigoApp());
}
