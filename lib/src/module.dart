import 'package:flutter/material.dart';

abstract class Module {
  final String moduleRoute;
  final Widget initialPage;
  final Map<String, dynamic> routes;
  final List<Object> moduleBinds;

  Module({
    required this.initialPage,
    required this.moduleRoute,
    required this.routes,
    required this.moduleBinds,
  });
}