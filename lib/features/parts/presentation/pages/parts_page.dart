import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/network/api_client.dart';
import '../../../../shared/presentation/ui_helper.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

import '../../data/repositories/parts_repository_impl.dart';
import '../../domain/usecases/get_parts.dart';
import '../bloc/parts_bloc.dart';

class PartsPage extends StatelessWidget {
  const PartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize repository and use-case
    final apiClient = context.read<ApiClient>();
    final repository = PartsRepositoryImpl(apiClient: apiClient);
    final getParts = GetPartsUseCase(repository);

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) context.go('/login');
          },
        ),
      ],
      child: BlocProvider(
        create: (_) => PartsBloc(getPartsUseCase: getParts)..add(GetAllParts()),
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: appBar(context),
          body: scaffoldBody(),
        ),
      ),
    );
  }

  Widget scaffoldBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: cardDecoration(),
        child: BlocBuilder<PartsBloc, PartsState>(
          builder: (context, state) {
            if (state is PartsLoading) {
              return const PartsLoadingView();
            }

            if (state is PartsError) {
              return PartsErrorView(message: state.message);
            }

            if (state is PartsLoaded) {
              if (state.parts.isEmpty) {
                return const PartsEmptyView();
              }

              return PartsTableView(partsState: state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: Text(
        'Parts',
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.grey[800],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          height: 1,
          color: Colors.grey[200],
        ),
      ),
      actionsPadding: const EdgeInsets.only(right: 16.0),
      actions: [
        accountView(context),
      ],
    );
  }

  Widget accountView(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        print('Selected: $result');
      },
      offset: Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey[600],
              size: 18,
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'profile',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.person_outline, size: 20),
            title: Text(
              'Profile',
              style: GoogleFonts.inter(fontSize: 14),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'settings',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.settings_outlined, size: 20),
            title: Text(
              'Settings',
              style: GoogleFonts.inter(fontSize: 14),
            ),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.logout, size: 20, color: Colors.red[600]),
            title: Text(
              'Logout',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.red[600],
              ),
            ),
          ),
          onTap: () {
            context.read<AuthBloc>().add(LogoutRequested());
          },
        ),
      ],
    );
  }
}

class PartsLoadingView extends StatelessWidget {
  const PartsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFF1565C0),
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            Text(
              'Loading parts...',
              style: GoogleFonts.inter(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartsErrorView extends StatelessWidget {
  final String message;
  const PartsErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class PartsEmptyView extends StatelessWidget {
  const PartsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No parts found',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first part to get started',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartsTableView extends StatelessWidget {
  final PartsLoaded partsState;
  const PartsTableView({super.key, required this.partsState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomSearchBar(
                  hintText: "Search parts...",
                  onChanged: (query) {},
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () => context.push('/add-part'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(0, 48),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                icon: const Icon(Icons.add, size: 18),
                label: Text(
                  'Add Part',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: DataTable(
                headingRowHeight: 56,
                dataRowMinHeight: 48,
                dataRowMaxHeight: 48,
                columnSpacing: 24,
                horizontalMargin: 24,
                headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
                dividerThickness: 1,
                columns: [
                  DataColumn(
                    label: Text(
                      'Part Number',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Description',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Part Type',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
                rows: partsState.parts.asMap().entries.map((entry) {
                  final index = entry.key;
                  final part = entry.value;
                  final isEven = index % 2 == 0;

                  return DataRow(
                    color: MaterialStateProperty.all(
                      isEven ? Colors.white : Colors.grey[25],
                    ),
                    cells: [
                      DataCell(
                        Text(
                          part.partNumber ?? "-",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                        ),
                        onTap: () {
                          context.push(
                              '/parts/${part.partId}/${Uri.encodeComponent(part.partNumber ?? '')}');
                        },
                      ),
                      DataCell(
                        Text(
                          part.description ?? "-",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          context.go('/parts/${part.partId}');
                        },
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Text(
                            part.partType ?? "N/A",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        onTap: () {
                          context.push(
                              '/parts/${part.partId}/${Uri.encodeComponent(part.partNumber ?? '')}');
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const CustomSearchBar({
    Key? key,
    required this.onChanged,
    this.hintText = "Search...",
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 320),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isFocused ? Color(0xFF1565C0) : Colors.grey[200]!,
          width: _isFocused ? 2 : 1,
        ),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        style: GoogleFonts.inter(fontSize: 14),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.inter(
            color: Colors.grey[500],
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          prefixIcon: Icon(
            Icons.search,
            color: _isFocused ? Color(0xFF1565C0) : Colors.grey[400],
            size: 20,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  onPressed: _clearSearch,
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[400],
                    size: 18,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
