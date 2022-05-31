import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:webroutingtest/api_data.dart';
import 'package:webroutingtest/login_page.dart';
import 'package:webroutingtest/model/login_data.dart';
import 'package:webroutingtest/route/build_route_map.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginData().createPrefObject();
  setUrlStrategy(PathUrlStrategy());
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<ApiData>(
        create: (context) => ApiData(),
      ),
      ChangeNotifierProvider<LoginData>(
        create: (context) => LoginData(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  final RouteInformationProvider? routeInformationProvider;

  const MyApp({Key? key, this.routeInformationProvider}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<LoginData>().loadEmailFromSharedPref();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
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
    );
  }
}

class MyDataPage extends StatelessWidget {
  const MyDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ApiData>().fetchData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<LoginData>().deleteEmailFromSharedPref();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => const LoginPage()));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        child: Consumer<ApiData>(
          builder: (context, value, child) {
            return value.users.isEmpty
                ? const Center(child: CircularProgressIndicator())
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
