import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtil {
  static DecorationImage imageNetwork(String url, {BoxFit? fit, ColorFilter? filter}) {
    return DecorationImage(image: NetworkImage(url), fit: fit ?? BoxFit.cover, colorFilter: filter);
  }

  static DecorationImage imageAsset(String url, {BoxFit? fit, ColorFilter? filter}) {
    return DecorationImage(image: AssetImage(url), fit: fit ?? BoxFit.cover, colorFilter: filter);
  }

  static DecorationImage imageFile(File file, {BoxFit? fit, ColorFilter? filter}) {
    return DecorationImage(image: FileImage(file), fit: fit ?? BoxFit.cover, colorFilter: filter);
  }

  static Uint8List toUint(String source) => base64.decode(source.replaceAll(RegExp(r'data:image\/(?:jpg|jpeg|png);base64,'), ''));

  static Future<File> toFile(Uint8List bytes, String name) async {
    String _dir = (await getApplicationDocumentsDirectory()).path;
    File _file = File('$_dir/$name.jpg');
    _file.writeAsBytesSync(bytes);
    return _file;
  }
}
