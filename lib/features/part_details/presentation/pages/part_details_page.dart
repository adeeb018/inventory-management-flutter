import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/network/api_client.dart';
import '../../data/repositories/part_details_repository_impl.dart';
import '../../domain/usecases/get_part_details.dart';
import '../bloc/part_details_bloc.dart';
import '../../domain/entities/part_details.dart';
import 'dart:convert';

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
    // Initialize repository and use-case like PartsPage
    final apiClient = context.read<ApiClient>();
    final repository = PartDetailsRepositoryImpl(apiClient: apiClient);
    final getPartDetails = GetPartDetailsUseCase(repository);

    return BlocProvider(
      create: (_) => PartDetailsBloc(getPartDetailsUseCase: getPartDetails)
        ..add(FetchPartDetails(partNumber)),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
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
            preferredSize: Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Colors.grey[200],
            ),
          ),
        ),
        body: BlocBuilder<PartDetailsBloc, PartDetailsState>(
          builder: (context, state) {
            if (state is PartDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF1565C0),
                  strokeWidth: 2,
                ),
              );
            }
            if (state is PartDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            }
            if (state is PartDetailsLoaded) {
              final d = state.details;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1565C0).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.memory,
                                  color: Color(0xFF1565C0),
                                  size: 32,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      d.partNumber,
                                      style: GoogleFonts.inter(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xFF1565C0).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        d.partType,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1565C0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
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
                          SizedBox(height: 16),
                          Text(
                            d.description,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Stock Summary Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.inventory,
                              color: Colors.green[600],
                              size: 32,
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Stock (Including Alternates)',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${d.totalStockIncludingAlternates} Units',
                                style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Location Details
                    _buildLocationDetails(d.manufacturerParts),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildManufacturerTable(List<dynamic> manufacturerParts) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => Colors.grey[50]!,
        ),
        headingTextStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.grey[700],
        ),
        dataTextStyle: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.grey[800],
        ),
        columns: [
          DataColumn(label: Text('Manufacturer')),
          DataColumn(label: Text('Part Number')),
          DataColumn(label: Text('Stock'), numeric: true),
          DataColumn(label: Text('Locations'), numeric: true),
        ],
        rows: manufacturerParts.map<DataRow>((part) {
          return DataRow(
            cells: [
              DataCell(
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        part['manufacturer'],
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DataCell(
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    part['manufacturer_part_number'],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[700],
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              DataCell(
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${part['stock']}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ),
              DataCell(
                Text('${(part['locations'] as List).length}'),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLocationDetails(List<ManufacturerPart> manufacturerParts) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            ...manufacturerParts.map<Widget>((part) {
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(16),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            part.manufacturerPartNumber,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700],
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          part.manufacturer,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ...(part.locations).map<Widget>((location) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                location.location,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${location.quantity} units',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange[700],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getPartDataFromJson() {
    // Your JSON data
    const String jsonString = '''
    {
      "part_number": "P-001",
      "part_type": "Sensor", 
      "description": "Temperature Sensor",
      "total_stock_including_alternates": 225,
      "manufacturer_parts": [
        {
          "manufacturer_part_number": "KTY81-210",
          "manufacturer": "Samsung Electronics",
          "stock": 75,
          "locations": [
            {
              "warehouse": "Secondary Warehouse",
              "location": "Warehouse B - Secondary - B-01",
              "quantity": 75
            }
          ]
        },
        {
          "manufacturer_part_number": "TMP36GT9Z",
          "manufacturer": "Texas Instruments", 
          "stock": 150,
          "locations": [
            {
              "warehouse": "Main Warehouse",
              "location": "Warehouse A - Main - A-01",
              "quantity": 70
            },
            {
              "warehouse": "Secondary Warehouse",
              "location": "Warehouse B - Secondary - B-01", 
              "quantity": 80
            }
          ]
        }
      ]
    }
    ''';

    return json.decode(jsonString);
  }
}
