import 'dart:io';

/// Fixture reader help us to read statci responses from the disk.
String fixture(String fileName) => File('test/fixtures/$fileName').readAsStringSync();
