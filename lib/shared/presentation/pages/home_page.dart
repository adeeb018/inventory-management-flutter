import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/parts')) return 0;
    if (location.startsWith('/composite-items')) return 1;
    if (location.startsWith('/assemblies')) return 2;
    if (location.startsWith('/projects')) return 3;
    return 0;
  }

  void _onDestinationSelected(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/parts');
        break;
      case 1:
        context.go('/composite-items');
        break;
      case 2:
        context.go('/assemblies');
        break;
      case 3:
        context.go('/projects');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // clean white menu
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: NavigationRailTheme(
                      data: NavigationRailThemeData(
                        indicatorColor: Colors
                            .transparent, // 🔥 removes the default selection bubble
                        selectedIconTheme: const IconThemeData(
                          color: Colors.black87,
                          size: 28,
                        ),
                        unselectedIconTheme: const IconThemeData(
                          color: Colors.black54,
                          size: 24,
                        ),
                        selectedLabelTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        unselectedLabelTextStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      child: NavigationRail(
                        selectedIndex: _getSelectedIndex(context),
                        onDestinationSelected: (index) =>
                            _onDestinationSelected(index, context),
                        extended: constraints.maxWidth >=
                            800, // open only on wide screens
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: constraints.maxWidth >= 600
                              ? Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/warehouse.png',
                                      width: 28,
                                      height: 28,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Inventory',
                                      style: GoogleFonts.robotoSlab(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              : Image.asset(
                                  'assets/images/warehouse.png',
                                  width: 28,
                                  height: 28,
                                ),
                        ),
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.inventory_2_outlined),
                            selectedIcon: Icon(Icons.inventory_2),
                            label: Text('Parts'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.layers_outlined),
                            selectedIcon: Icon(Icons.layers),
                            label: Text('Composite'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.build_outlined),
                            selectedIcon: Icon(Icons.build),
                            label: Text('Assemblies'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[50], // light neutral background
                  child: widget.child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
