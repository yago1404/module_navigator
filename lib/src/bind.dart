import 'package:provider/provider.dart';

class Bind<T> {
  final T instance;

  Bind(this.instance);

  Provider<T> passToProvider() {
    return Provider<T>(create: (_) => instance);
  }
}