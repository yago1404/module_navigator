import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bind<T> {
  final T Function(BuildContext context) instance;

  Bind(this.instance);

  Provider<T> passToProvider() {
    return Provider<T>(create: instance);
  }
}
