import 'package:flutter/material.dart';
import 'package:module_navigator/module_navigator.dart';
import 'package:module_navigator/src/extensions/app_extension.dart';
import 'package:module_navigator/src/route_provider.dart';
import 'package:provider/provider.dart';

import 'navigator_observer.dart';

class MaterialModule extends StatelessWidget {
  final MaterialApp materialApp;
  final List<Module> modules;
  final List<NavigatorObserver>? navigatorObservers;
  final List<Bind>? initialBinds;

  const MaterialModule({
    super.key,
    required this.materialApp,
    required this.modules,
    this.navigatorObservers,
    this.initialBinds,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ..._initBinds(),
      ],
      child: materialApp.adaptation(
        navigatorObserver: CustomNavigatorObserver(),
        routes: _initRoutes(),
      ),
    );
  }

  Map<String, Widget Function(BuildContext context)> _initRoutes() {
    final Map<String, Widget Function(BuildContext context)> routes = {};
    for (Module module in modules) {
      _extractRoutesFromModules(module, routes);
    }
    return routes;
  }

  void _extractRoutesFromModules(
    Module module,
    Map<String, Widget Function(BuildContext context)> routes, {
    String? prefix,
  }) {
    String baseRoute = '${prefix ?? ''}${module.moduleRoute}'.trim();
    debugPrint('LoadRoute: $baseRoute');
    routes[baseRoute] = module.initialPage;
    for (String route in module.routes.keys) {
      if (module.routes[route] is Module) {
        _extractRoutesFromModules(module.routes[route], routes,
            prefix: '${prefix ?? ''}${module.moduleRoute}');
        continue;
      }
      if (module.routes[route] is Widget Function(BuildContext context)) {
        routes['${module.moduleRoute}$route'] = module.routes[route]!;
      } else {
        throw Exception(
            'sub-module must be a \'Module\' or a \'Widget Function(BuildContext context)\'');
      }
      debugPrint('LoadRoute: ${module.moduleRoute}$route');
    }
  }

  List<Provider> _initBinds() {
    List<Provider> providersInstances = [
      Provider<RouteProvider>(create: (_) => RouteProvider()),
    ];
    for (Bind initialSingleton in initialBinds ?? []) {
      if (providersInstances.contains(initialSingleton.passToProvider())) {
        continue;
      }
      providersInstances.add(initialSingleton.passToProvider());
    }
    for (Module module in modules) {
      for (Bind singleton in module.moduleBinds) {
        if (providersInstances.contains(singleton.passToProvider())) {
          continue;
        }
        providersInstances.add(singleton.passToProvider());
      }
    }
    return providersInstances;
  }
}
