import 'package:flutter/material.dart';

import '../navigator_observer.dart';

extension MaterialAppExtension on MaterialApp {
  MaterialApp adaptation({
    required CustomNavigatorObserver navigatorObserver,
    required Map<String, Widget Function(BuildContext)> routes,
  }) {
    return MaterialApp(
      routes: routes,
      navigatorObservers: [
        ...navigatorObservers ?? [],
        navigatorObserver,
      ],
      key: key,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      initialRoute: initialRoute,
      builder: builder,
      title: title,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: locale,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      onGenerateTitle: onGenerateTitle,
      onUnknownRoute: onUnknownRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onNavigationNotification: onNavigationNotification,
      color: color,
      highContrastTheme: highContrastTheme,
      highContrastDarkTheme: highContrastDarkTheme,
      themeAnimationDuration: themeAnimationDuration,
      themeAnimationCurve: themeAnimationCurve,
      debugShowMaterialGrid: debugShowMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior,
      useInheritedMediaQuery: useInheritedMediaQuery,
      themeAnimationStyle: themeAnimationStyle,
    );
  }
}
