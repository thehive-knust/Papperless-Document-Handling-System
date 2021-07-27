//
// Generated file. Do not edit.
//

// ignore_for_file: lines_longer_than_80_chars

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:native_pdf_renderer/src/web/native_pdf_renderer_plugin.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  FilePickerWeb.registerWith(registrar);
  NativePdfRendererPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
