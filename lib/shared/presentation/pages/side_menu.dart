import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatefulWidget {
  final Widget child;

  const SideMenu({super.key, required this.child});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
        final selectedIndex = _getSelectedIndex(context);
        final isExtended = constraints.maxWidth >= 800;
        final showTitleInHeader = constraints.maxWidth >= 600;
        return Scaffold(
          body: _scaffoldBody(
              selectedIndex, isExtended, showTitleInHeader, context),
        );
      },
    );
  }

  Row _scaffoldBody(int selectedIndex, bool isExtended, bool showTitleInHeader,
      BuildContext context) {
    return Row(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // clean white menu
                borderRadius: BorderRadius.circular(16),
              ),
              child: SideMenuRail(
                selectedIndex: selectedIndex,
                isExtended: isExtended,
                showTitleInHeader: showTitleInHeader,
                onDestinationSelected: (index) =>
                    _onDestinationSelected(index, context),
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
    );
  }
}

class SideMenuRail extends StatelessWidget {
  final int selectedIndex;
  final bool isExtended;
  final bool showTitleInHeader;
  final ValueChanged<int> onDestinationSelected;

  const SideMenuRail({
    super.key,
    required this.selectedIndex,
    required this.isExtended,
    required this.showTitleInHeader,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRailTheme(
      data: const NavigationRailThemeData(
        indicatorColor: Colors.transparent,
        selectedIconTheme: IconThemeData(
          color: Colors.black87,
          size: 28,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.black54,
          size: 24,
        ),
        selectedLabelTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: Colors.black54,
        ),
        backgroundColor: Colors.transparent,
      ),
      child: NavigationRail(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        extended: isExtended,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RailHeader(showTitle: showTitleInHeader),
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
    );
  }
}

class RailHeader extends StatelessWidget {
  final bool showTitle;
  const RailHeader({super.key, required this.showTitle});

  @override
  Widget build(BuildContext context) {
    if (showTitle) {
      return Row(
        children: [
          Image.asset('assets/images/warehouse.png', width: 28, height: 28),
          const SizedBox(width: 8),
          Text(
            'Inventory',
            style: GoogleFonts.robotoSlab(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
    return Image.asset('assets/images/warehouse.png', width: 28, height: 28);
  }
}
