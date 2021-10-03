import 'package:admin_screen/AdminUser.dart';
import 'package:admin_screen/portfolio_provider.dart';
import 'package:admin_screen/search_results_provider.dart';
import 'package:admin_screen/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchResultsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PortfolioProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminUser(),
      ),
    );
  }
}
