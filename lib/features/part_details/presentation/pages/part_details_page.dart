// // First, create the PartDetailPage
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';

// class PartDetailPage extends StatelessWidget {
//   final String partId;
//   final String partNumber;

//   const PartDetailPage(
//       {super.key, required this.partId, required this.partNumber});

//   @override
//   Widget build(BuildContext context) {
//     // In a real app, you would fetch the part details using the partId
//     // For now, we'll use mock data
//     final part = _getMockPartData(partId, partNumber);

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         centerTitle: false,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => context.go('/parts'),
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.grey[800],
//           ),
//         ),
//         title: Text(
//           'Part Details',
//           style: GoogleFonts.inter(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.grey[800],
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(1),
//           child: Container(
//             height: 1,
//             color: Colors.grey[200],
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Card
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     blurRadius: 12,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF1565C0).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           Icons.inventory_2_outlined,
//                           color: Color(0xFF1565C0),
//                           size: 32,
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               part['partNumber'] ?? 'Unknown Part',
//                               style: GoogleFonts.inter(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey[800],
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFF1565C0).withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Text(
//                                 'ID: ${part['partId']}',
//                                 style: GoogleFonts.inter(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xFF1565C0),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.green[50],
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.green[200]!),
//                         ),
//                         child: Text(
//                           'Active',
//                           style: GoogleFonts.inter(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.green[700],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     part['description'] ?? 'No description available',
//                     style: GoogleFonts.inter(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                       height: 1.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 24),

//             // Details Grid
//             Expanded(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Left Column - Basic Info
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.04),
//                             blurRadius: 12,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Basic Information',
//                             style: GoogleFonts.inter(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey[800],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           _buildInfoRow('Part Type', part['partType']),
//                           _buildInfoRow('Category', part['category']),
//                           _buildInfoRow('Manufacturer', part['manufacturer']),
//                           _buildInfoRow('Model Number', part['modelNumber']),
//                           _buildInfoRow('Serial Number', part['serialNumber']),
//                           _buildInfoRow('Weight', part['weight']),
//                           _buildInfoRow('Dimensions', part['dimensions']),
//                         ],
//                       ),
//                     ),
//                   ),

//                   SizedBox(width: 24),

//                   // Right Column - Inventory & Actions
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       children: [
//                         // Inventory Info
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(24),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.04),
//                                 blurRadius: 12,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Inventory Status',
//                                 style: GoogleFonts.inter(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.grey[800],
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               _buildStockItem(
//                                   'In Stock', part['inStock'], Colors.green),
//                               SizedBox(height: 12),
//                               _buildStockItem(
//                                   'Reserved', part['reserved'], Colors.orange),
//                               SizedBox(height: 12),
//                               _buildStockItem(
//                                   'On Order', part['onOrder'], Colors.blue),
//                               SizedBox(height: 20),
//                               Container(
//                                 width: double.infinity,
//                                 height: 1,
//                                 color: Colors.grey[200],
//                               ),
//                               SizedBox(height: 20),
//                               _buildInfoRow(
//                                   'Min Stock Level', part['minStock']),
//                               _buildInfoRow(
//                                   'Max Stock Level', part['maxStock']),
//                               _buildInfoRow(
//                                   'Reorder Point', part['reorderPoint']),
//                             ],
//                           ),
//                         ),

//                         // SizedBox(height: 24),

//                         // Actions
//                         // Container(
//                         //   width: double.infinity,
//                         //   padding: const EdgeInsets.all(24),
//                         //   decoration: BoxDecoration(
//                         //     color: Colors.white,
//                         //     borderRadius: BorderRadius.circular(16),
//                         //     boxShadow: [
//                         //       BoxShadow(
//                         //         color: Colors.black.withOpacity(0.04),
//                         //         blurRadius: 12,
//                         //         offset: const Offset(0, 2),
//                         //       ),
//                         //     ],
//                         //   ),
//                         //   child: Column(
//                         //     crossAxisAlignment: CrossAxisAlignment.start,
//                         //     children: [
//                         //       Text(
//                         //         'Actions',
//                         //         style: GoogleFonts.inter(
//                         //           fontSize: 18,
//                         //           fontWeight: FontWeight.bold,
//                         //           color: Colors.grey[800],
//                         //         ),
//                         //       ),
//                         //       SizedBox(height: 16),
//                         //       _buildActionButton(
//                         //         'Edit Part',
//                         //         Icons.edit_outlined,
//                         //         Color(0xFF1565C0),
//                         //         () {},
//                         //       ),
//                         //       SizedBox(height: 12),
//                         //       _buildActionButton(
//                         //         'Update Stock',
//                         //         Icons.inventory_outlined,
//                         //         Colors.green[600]!,
//                         //         () {},
//                         //       ),
//                         //       SizedBox(height: 12),
//                         //       _buildActionButton(
//                         //         'View History',
//                         //         Icons.history,
//                         //         Colors.grey[600]!,
//                         //         () {},
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String? value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               label,
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value ?? '-',
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 color: Colors.grey[800],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStockItem(String label, String? value, Color color) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.inter(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.grey[700],
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             value ?? '0',
//             style: GoogleFonts.inter(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: color,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton(
//     String label,
//     IconData icon,
//     Color color,
//     VoidCallback onTap,
//   ) {
//     return SizedBox(
//       width: double.infinity,
//       child: OutlinedButton.icon(
//         onPressed: onTap,
//         icon: Icon(icon, size: 18, color: color),
//         label: Text(
//           label,
//           style: GoogleFonts.inter(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: color,
//           ),
//         ),
//         style: OutlinedButton.styleFrom(
//           side: BorderSide(color: color.withOpacity(0.3)),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         ),
//       ),
//     );
//   }

//   Map<String, String> _getMockPartData(String partId, String partNumber) {
//     // Mock data - in a real app, fetch from your repository/API
//     return {
//       'partId': partId,
//       'partNumber': partNumber,
//       'description': '',
//       'partType': 'Mechanical',
//       'category': 'Engine Components',
//       'manufacturer': 'AutoParts Corp',
//       'modelNumber': 'AP-${partId}-X',
//       'serialNumber': 'SN${DateTime.now().millisecondsSinceEpoch}',
//       'weight': '2.5 kg',
//       'dimensions': '15cm x 10cm x 8cm',
//       'inStock': '45',
//       'reserved': '12',
//       'onOrder': '20',
//       'minStock': '10',
//       'maxStock': '100',
//       'reorderPoint': '15',
//     };
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
    // Parse the JSON data
    final partData = _getPartDataFromJson();

    return Scaffold(
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
      body: SingleChildScrollView(
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
                              partData['part_number'] ?? 'Unknown Part',
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
                                color: Color(0xFF1565C0).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                partData['part_type'] ?? 'Unknown Type',
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
                    partData['description'] ?? 'No description available',
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
                        '${partData['total_stock_including_alternates']} Units',
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

            // Manufacturer Parts Table
            // Container(
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.04),
            //         blurRadius: 12,
            //         offset: const Offset(0, 2),
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(24),
            //         child: Text(
            //           'Manufacturer Details',
            //           style: GoogleFonts.inter(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.grey[800],
            //           ),
            //         ),
            //       ),
            //       _buildManufacturerTable(partData['manufacturer_parts']),
            //     ],
            //   ),
            // ),

            // SizedBox(height: 24),

            // Location Details
            _buildLocationDetails(partData['manufacturer_parts']),
          ],
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

  Widget _buildLocationDetails(List<dynamic> manufacturerParts) {
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
                            part['manufacturer_part_number'],
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700],
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          part['manufacturer'],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ...(part['locations'] as List).map<Widget>((location) {
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
                                location['location'],
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
                                '${location['quantity']} units',
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
