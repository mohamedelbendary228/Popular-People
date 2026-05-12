import 'dart:isolate';

import 'package:popular_people/core/services/dio/dio_client_impl.dart';

class IsolateParser<T> {
  final Map<String, dynamic> json;
  ResponseConverter<T> converter;

  IsolateParser(this.json, this.converter);

  Future<T> parseInBackground() async {
    return await Isolate.run(() => converter(json));
  }
}
