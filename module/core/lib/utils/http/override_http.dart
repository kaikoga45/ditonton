import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class HttpOverride {
  static Future<SecurityContext> get globalContext async {
    final sslCert =
        await rootBundle.load('module/core/certificates/themoviedb.org.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  static Future<http.Client> createLEClient() async {
    final client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    final ioClient = IOClient(client);
    return ioClient;
  }
}
