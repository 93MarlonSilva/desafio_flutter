import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:quizchallenge/common/providers.dart';
import 'common/theme.dart';
import 'common/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers.cast<SingleChildWidget>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz Challenge',
        theme: AppTheme.lightTheme,
        initialRoute: Routes.home,
        routes: Routes.routes,
        navigatorKey: GlobalKey<NavigatorState>(),
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder:
                (context) => WillPopScope(
                  onWillPop: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                      return false;
                    }
                    return true;
                  },
                  child: Routes.getRoute(settings.name),
                ),
          );
        },
      ),
    );
  }
}
