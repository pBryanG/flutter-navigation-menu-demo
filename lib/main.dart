import 'package:app/drawer_menu.dart';
import 'package:flutter/material.dart';

import 'sliding_menu.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Navigation Flutter Menu App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// https://docs.flutter.dev/development/ui/animations/tutorial#animationcontroller
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _menuSlideController;
  bool showMenu = false;

  @override
  void initState() {
    super.initState();

    _menuSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _menuSlideController.dispose();
    super.dispose();
  }

  /* ------- Animation builder functions ------- */
  bool _isMenuOpen() {
    return _menuSlideController.value == 1.0;
  }

  bool _isMenuOpening() {
    return _menuSlideController.status == AnimationStatus.forward;
  }

  bool _isMenuClosed() {
    return _menuSlideController.value == 0.0;
  }

  void _toggleMenu() {
    if (_isMenuOpen() || _isMenuOpening()) {
      _menuSlideController.reverse();
    } else {
      _menuSlideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
                fit: BoxFit.fitHeight,
                height: 30,
                image: NetworkImage("https://avatars.githubusercontent.com/u/11708465?s=400&u=2f0a9dc6e6287f8ac690a8246ce297f8bb81692e&v=4")),
          ],
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://booth.pximg.net/418438d7-7722-4249-b229-e2737a853b35/i/3827588/0ab8f246-64cd-46a1-9ea2-0b84bfd10ba1_base_resized.jpg"),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: [
          AnimatedBuilder(
            animation: _menuSlideController,
            builder: (context, child) {
              return Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: showMenu,
                child: IconButton(
                  onPressed: _toggleMenu,
                  icon: _isMenuOpen() || _isMenuOpening()
                      ? const Icon(
                          Icons.menu_open,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "This is the main page",
                  style: TextStyle(fontSize: 30),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Check the todo item below to open the menu above to check more pages.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ),
                ListTile(
                  title: Text(
                    'check this todo item',
                    style: TextStyle(decoration: showMenu ? TextDecoration.lineThrough : TextDecoration.none),
                  ),
                  minVerticalPadding: 25.0,
                  tileColor: Colors.black12,
                  onTap: () {
                    setState(() {
                      showMenu = true;
                    });
                  },
                )
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _menuSlideController,
            builder: (context, child) {
              return FractionalTranslation(
                translation: Offset(1.0 - _menuSlideController.value, 0.0),
                child: _isMenuClosed() ? const SizedBox() : const SlidingMenu(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TourPage extends StatelessWidget {
  const TourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "This is the Tour page 🚩",
              style: TextStyle(fontSize: 30),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "As you can say, this is just a sample page. You can go back by pressing the button below.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "This is the Settings page ⚙️",
              style: TextStyle(fontSize: 30),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "As you can say, this is just a sample page. You can go back by pressing the button below.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
