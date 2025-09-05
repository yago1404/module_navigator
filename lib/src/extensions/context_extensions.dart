import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension CustomContextExtension on BuildContext {
  T get<T>() {
    return Provider.of<T>(this, listen: false);
  }
}