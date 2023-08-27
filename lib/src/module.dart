import 'package:flutter/material.dart';
import 'package:module_navigator/module_navigator.dart';

abstract class Module {
  final String moduleRoute;
  final Widget initialPage;
  final Map<String, dynamic> routes;
  final List<Bind> moduleBinds;

  Module({
    required this.initialPage,
    required this.moduleRoute,
    required this.routes,
    required this.moduleBinds,
  });
}