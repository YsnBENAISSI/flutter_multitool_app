import 'package:flutter/material.dart';

import 'Pages/Calculatrice.dart';
import 'Pages/Weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MENU',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      drawer: const CommonDrawer(currentPage: 'Home'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade700],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              MenuCard(
                title: 'Calculatrice',
                icon: Icons.calculate,
                description: 'Pour calculer',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CalculatorPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              MenuCard(
                title: 'Météo',
                icon: Icons.cloud,
                description: 'Consulter la météo par ville',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WeatherPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final VoidCallback onTap;

  const MenuCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Colors.blue),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonDrawer extends StatelessWidget {
  final String currentPage;

  const CommonDrawer({Key? key, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade300, Colors.blue.shade700],
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu: Multitools',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Votre boîte à outils tout-en-un',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: currentPage == 'home',
            onTap: () {
              if (currentPage != 'home') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainMenuPage()),
                      (route) => false,
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Calculator'),
            selected: currentPage == 'calculator',
            onTap: () {
              if (currentPage != 'calculator') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CalculatorPage()),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Weather'),
            selected: currentPage == 'weather',
            onTap: () {
              if (currentPage != 'weather') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherPage()),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}