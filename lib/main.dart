import 'package:flutter/material.dart';
import 'package:xtreme_movie_app/modules/favorite/favorite_page.dart';
import 'package:xtreme_movie_app/modules/search/search_page.dart';
import 'package:xtreme_movie_app/repositories/database_creator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _title = 'Xtreme Movie App';
  final List<Widget> _navBarWidgets = [SearchPage(), FavoritePage()];

  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xtreme Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(_title),
          ),
          body: Container(
            child: _navBarWidgets.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: _MyAppBottomNavBar(
            _selectedIndex,
            _onNavItemTapped,
          )),
    );
  }
}

class _MyAppBottomNavBar extends StatelessWidget {
  final int _selectedIndex;
  final void Function(int) _onNavItemTapped;

  _MyAppBottomNavBar(this._selectedIndex, this._onNavItemTapped);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Buscar'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Favoritos'),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onNavItemTapped,
    );
  }
}
