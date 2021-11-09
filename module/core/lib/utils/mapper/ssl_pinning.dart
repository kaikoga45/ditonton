import 'dart:io';

import 'package:flutter/services.dart';

Future<SecurityContext> getGlobalContext(String name) async {
  final sslCert = await rootBundle.load('certificates/$name');
  final securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}
