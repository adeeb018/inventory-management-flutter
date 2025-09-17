import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/presentation/ui_helper.dart';
import '../../data/repositories/part_details_repository_impl.dart';
import '../../domain/usecases/get_part_details.dart';
import '../bloc/part_details_bloc.dart';
import '../../domain/entities/part_details.dart';

class PartDetailPage extends StatelessWidget {
  final String partId;
  final String partNumber;

  const PartDetailPage({
    super.key,
    required this.partId,
    required this.partNumber,
  });

  @override
  Widget build(BuildContext context) {
    final apiClient = context.read<ApiClient>();
    final repository = PartDetailsRepositoryImpl(apiClient: apiClient);
    final getPartDetails = GetPartDetailsUseCase(repository);

    return BlocProvider(
      create: (_) => PartDetailsBloc(getPartDetailsUseCase: getPartDetails)
        ..add(FetchPartDetails(partNumber)),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: _appBar(context),
        body: _scaffoldBody(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      elevation: 0,
      leading: IconButton(
        onPressed: () => context.go('/parts'),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
        ),
      ),
      title: Text(
        'Part Details',
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.grey[800],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }

  BlocBuilder<PartDetailsBloc, PartDetailsState> _scaffoldBody() {
    return BlocBuilder<PartDetailsBloc, PartDetailsState>(
      builder: (context, state) {
        if (state is PartDetailsLoading) {
          return const CenteredLoader();
        }
        if (state is PartDetailsError) {
          return CenteredError(message: state.message);
        }
        if (state is PartDetailsLoaded) {
          final partDetails = state.details;
          return _partDetailsWidget(partDetails);
        }
        return const SizedBox.shrink();
      },
    );
  }

  SingleChildScrollView _partDetailsWidget(PartDetails details) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PartHeaderCard(details: details),
          const SizedBox(height: 24),
          StockSummaryCard(details: details),
          const SizedBox(height: 24),
          LocationSection(manufacturerParts: details.manufacturerParts),
        ],
      ),
    );
  }
}

class CenteredLoader extends StatelessWidget {
  const CenteredLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF1565C0),
        strokeWidth: 2,
      ),
    );
  }
}

class CenteredError extends StatelessWidget {
  final String message;
  const CenteredError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: GoogleFonts.inter(fontSize: 14, color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PartHeaderCard extends StatelessWidget {
  final PartDetails details;
  const PartHeaderCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.memory,
                    color: Color(0xFF1565C0), size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.partNumber,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1565C0).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        details.partType,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1565C0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Text(
                  'In Stock',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            details.description,
            style: GoogleFonts.inter(
                fontSize: 16, color: Colors.grey[600], height: 1.5),
          ),
        ],
      ),
    );
  }
}

class StockSummaryCard extends StatelessWidget {
  final PartDetails details;
  const StockSummaryCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: cardDecoration(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.inventory, color: Colors.green[600], size: 32),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Stock (Including Alternates)',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                '${details.totalStockIncludingAlternates} Units',
                style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LocationSection extends StatelessWidget {
  final List<ManufacturerPart> manufacturerParts;
  const LocationSection({super.key, required this.manufacturerParts});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stock Locations',
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),
            ...manufacturerParts.map((p) => ManufacturerPartTile(part: p)),
          ],
        ),
      ),
    );
  }
}

class ManufacturerPartTile extends StatelessWidget {
  final ManufacturerPart part;
  const ManufacturerPartTile({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  part.manufacturerPartNumber,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700],
                      fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                part.manufacturer,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...part.locations.map((l) =>
              LocationRow(locationLabel: l.location, quantity: l.quantity)),
        ],
      ),
    );
  }
}

class LocationRow extends StatelessWidget {
  final String locationLabel;
  final int quantity;
  const LocationRow(
      {super.key, required this.locationLabel, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(locationLabel,
                style:
                    GoogleFonts.inter(fontSize: 14, color: Colors.grey[700])),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(6)),
            child: Text(
              '$quantity units',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: Colors.orange[700],
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
