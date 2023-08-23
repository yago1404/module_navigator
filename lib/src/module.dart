import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Module {
  final String moduleRoute;
  final Widget initialPage;
  final Map<String, dynamic> routes;
  final List<Provider> moduleBinds;

  Module({
    required this.initialPage,
    required this.moduleRoute,
    required this.routes,
    required this.moduleBinds,
  });
}