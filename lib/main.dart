import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/pages/home_page.dart';
import 'package:qr_reader_app/pages/map_page.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple)),
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'map': (_) => const MapPage(),
        },
      ),
    );
  }
}
