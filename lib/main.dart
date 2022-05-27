import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:webroutingtest/api_data.dart';
import 'package:webroutingtest/route/build_route_map.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final RouteInformationProvider? routeInformationProvider;

  const MyApp({Key? key, this.routeInformationProvider}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiData(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) {
            return buildRouteMap(context);
          },
        ),
        routeInformationParser: const RoutemasterParser(),
        routeInformationProvider: routeInformationProvider,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ApiData>().fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("HELLO!"),
      ),
      body: RefreshIndicator(
        child: Consumer<ApiData>(
          builder: (context, value, child) {
            return value.users.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: value.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(value.users[index].name.toString()),
                        subtitle: Text(value.users[index].email.toString()),
                      );
                    },
                  );
          },
        ),
        onRefresh: () async {
          await Provider.of<ApiData>(context, listen: false).fetchData();
        },
      ),
    );
  }
}
