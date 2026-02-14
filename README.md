# Module Navigator

Um pacote para modularizar aplicações Flutter, organizando rotas e gerenciando injeção de dependência de forma simples e escalável, utilizando o poder do [provider](https://pub.dev/packages/provider).

## Visão Geral

O `module_navigator` ajuda a estruturar seu projeto em módulos independentes. Cada módulo encapsula seu próprio conjunto de rotas, páginas e dependências (serviços, repositórios, etc.), promovendo uma arquitetura limpa e desacoplada.

## Recursos

- **Gerenciamento de Rotas Modularizado:** Defina rotas dentro de módulos, incluindo suporte para módulos aninhados.
- **Injeção de Dependência Desacoplada:** Registre dependências no módulo e injete-as diretamente no construtor de suas páginas, mantendo seus widgets limpos e independentes do contexto.
- **Arquitetura Limpa:** Isole funcionalidades em módulos para melhorar a manutenção e a escalabilidade.
- **Integração Simples:** Envolve seu `MaterialApp` com o `MaterialModule` e comece a usar.

## Como Começar

Adicione o `module_navigator` ao seu arquivo `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  module_navigator: <sua_versao_aqui> # Ex: ^1.0.0
```

## Uso

Veja como estruturar um aplicativo simples com `AppModule` e `HomeModule`.

### 1. Crie seus Módulos

Defina suas rotas e dependências implementando a interface `Module`. A melhor prática é usar `getters`.

**`lib/home/home_module.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:module_navigator/module_navigator.dart';
import './home_page.dart';
import './home_service.dart';

class HomeModule implements Module {
  @override
  Widget Function(BuildContext context) get initialPage =>
      (context) => HomePage(homeService: context.get<HomeService>());

  @override
  List<Bind> get moduleBinds => [
        Bind((context) => HomeService()),
      ];

  @override
  String get moduleRoute => '/home';

  @override
  Map<String, dynamic> get routes => {
        '/details': (context) => const DetailsPage(),
      };
}
```

### 2. Crie Páginas Desacopladas

Ao invés de usar `context.get<T>()` dentro das suas páginas, receba as dependências via construtor. Isso torna seus widgets mais puros e fáceis de testar.

**`lib/home/home_service.dart`**
```dart
class HomeService {
  String get message => 'Dados carregados do HomeService!';
}
```

**`lib/home/home_page.dart`**
```dart
import 'package:flutter/material.dart';
import './home_service.dart';

class HomePage extends StatelessWidget {
  final HomeService homeService;

  const HomePage({super.key, required this.homeService});

  @override
  Widget build(BuildContext context) {
    // A dependência agora é recebida pelo construtor!
    // Não há mais acoplamento com o `context.get` nesta página.

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(homeService.message),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/home/details');
              },
              child: const Text('Ir para Detalhes'),
            ),
          ],
        ),
      ),
    );
  }
}

// Outra página no mesmo módulo
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: const Center(child: Text('Página de detalhes do módulo Home.')),
    );
  }
}
```

### 3. Configure o `MaterialModule`

Crie um módulo raiz e, no seu `main.dart`, envolva seu `MaterialApp` com o widget `MaterialModule`, fornecendo a lista de todos os seus módulos.

**`lib/app_module.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:module_navigator/module_navigator.dart';

// Módulo Raiz
class AppModule implements Module {
  @override
  Widget Function(BuildContext context) get initialPage =>
      (context) => const SizedBox.shrink();

  @override
  List<Bind> get moduleBinds => const [];

  @override
  String get moduleRoute => '/';

  @override
  Map<String, dynamic> get routes => const {};
}
```

**`lib/main.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:module_navigator/module_navigator.dart';
import './app_module.dart';
import './home/home_module.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialModule(
      modules: [
        AppModule(),
        HomeModule(),
      ],
      materialApp: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/home',
      ),
    );
  }
}
```

### Navegação

A navegação funciona exatamente como no Flutter padrão. O `MaterialModule` cuida de montar as rotas para você.

```dart
// Navega para a rota /details dentro do HomeModule
Navigator.of(context).pushNamed('/home/details');

// Navega para a rota inicial de HomeModule
Navigator.of(context).pushNamed('/home');
```

## Informações Adicionais

Para exemplos mais complexos, como módulos aninhados, considere criar uma pasta `/example` no seu projeto. Sinta-se à vontade para abrir uma issue se encontrar problemas ou tiver sugestões.
