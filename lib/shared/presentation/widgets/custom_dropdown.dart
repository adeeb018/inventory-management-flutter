import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isRequired;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: Colors.grey[500],
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF1565C0), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          dropdownColor: Colors.white,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey[800],
          ),
          items: items,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}

// Helper class for dropdown data management
class DropdownData {
  static List<String> getPartTypes() {
    return [
      'Electronic Component',
      'Mechanical Part',
      'Software License',
      'Tool',
      'Accessory',
      'Consumable',
      'Hardware',
      'Other',
    ];
  }

  static List<String> getManufacturers() {
    return [
      'Intel',
      'AMD',
      'NVIDIA',
      'Samsung',
      'Apple',
      'Microsoft',
      'Google',
      'Dell',
      'HP',
      'Lenovo',
      'ASUS',
      'Gigabyte',
      'Corsair',
      'Kingston',
      'Western Digital',
      'Seagate',
      'Other',
    ];
  }

  static List<String> getWarehouses() {
    return [
      'Main Warehouse',
      'Secondary Warehouse',
      'Remote Storage',
      'Office Storage',
      'Lab Storage',
      'Other',
    ];
  }

  static List<String> getLocations() {
    return [
      'A1',
      'A2',
      'A3',
      'B1',
      'B2',
      'B3',
      'C1',
      'C2',
      'C3',
      'D1',
      'D2',
      'D3',
      'Other',
    ];
  }

  static List<String> getRacks() {
    return [
      'Rack 01',
      'Rack 02',
      'Rack 03',
      'Rack 04',
      'Rack 05',
      'Rack 06',
      'Rack 07',
      'Rack 08',
      'Rack 09',
      'Rack 10',
      'Other',
    ];
  }

  static List<String> getAlternatePartNumbers() {
    return [
      'ALT-001',
      'ALT-002',
      'ALT-003',
      'ALT-004',
      'ALT-005',
      'ALT-006',
      'ALT-007',
      'ALT-008',
      'ALT-009',
      'ALT-010',
      'Other',
    ];
  }
}
