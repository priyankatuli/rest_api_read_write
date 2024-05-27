import 'package:flutter/material.dart';
import 'package:rest_api_read_write/app.dart';
import 'package:device_preview_minus/device_preview_minus.dart';

void main(){
 runApp(
  DevicePreview(
   builder: (context) => const CrudApp(),
  ),
 );
}

