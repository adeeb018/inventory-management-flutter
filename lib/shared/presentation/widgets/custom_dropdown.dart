import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_widgets/custom_dropdown_menu.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final T? value;
  final List<CustomDropdownMenuEntry<String>> items;
  final void Function(String? value)? onSelected;
  final String? Function(T?)? validator;
  final bool isRequired;
  final String addItemBtnTitle;
  final Function()? onItemBtnClicked;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.items,
    this.value,
    this.onSelected,
    this.validator,
    this.isRequired = true,
    required this.addItemBtnTitle,
    required this.onItemBtnClicked,
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
        // DropdownButtonFormField<T>(
        //   value: value,
        //   onChanged: onChanged,
        //   validator: validator,
        //   decoration: InputDecoration(
        //     hintText: hint,
        //     prefixIcon: Icon(
        //       icon,
        //       color: Colors.grey[500],
        //       size: 20,
        //     ),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(color: Colors.grey[300]!),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(color: Colors.grey[300]!),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: const BorderSide(color: Color(0xFF1565C0), width: 2),
        //     ),
        //     errorBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: const BorderSide(color: Colors.red, width: 1),
        //     ),
        //     focusedErrorBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: const BorderSide(color: Colors.red, width: 2),
        //     ),
        //     filled: true,
        //     fillColor: Colors.grey[50],
        //     contentPadding: const EdgeInsets.symmetric(
        //       horizontal: 16,
        //       vertical: 16,
        //     ),
        //   ),
        //   dropdownColor: Colors.white,
        //   style: GoogleFonts.inter(
        //     fontSize: 14,
        //     color: Colors.grey[800],
        //   ),
        //   items: items,
        // icon: Icon(
        //   Icons.keyboard_arrow_down,
        //   color: Colors.grey[500],
        // ),
        // ),
        CustomDropdownMenu<String>(
          width: MediaQuery.of(context).size.width - 32,
          menuHeight: 200,
          hintText: hint,
          leadingIcon: Icon(
            icon,
            color: Colors.grey[500],
          ),
          enableSearch: true,
          enableFilter: true,
          requestFocusOnTap: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          // onSelected: (String? value) {
          //   setState(() {
          //     _selectedManufacturer = value;
          //   });
          // },
          onSelected: onSelected,
          // addItemBtnTitle: 'New Manufacturer',
          // onItemBtnClicked: () {
          //   debugPrint('add item button clicked');
          //   _showAddNewDialog(context);
          // },
          addItemBtnTitle: addItemBtnTitle,
          onItemBtnClicked: onItemBtnClicked,
          // dropdownMenuEntries: DropdownData.getManufacturers()
          //     .map<CustomDropdownMenuEntry<String>>((String manufacturerName) {
          //   return CustomDropdownMenuEntry<String>(
          //     value: manufacturerName,
          //     label: manufacturerName,
          //     leadingIcon: const Icon(Icons.business, size: 18),
          //   );
          // }).toList(),
          dropdownMenuEntries: items,
        ),
      ],
    );
  }
}

// Enhanced dropdown with Add New and Clear functionality
class EnhancedCustomDropdown<T> extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final T? value;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isRequired;
  final bool allowAddNew;
  final bool allowClear;
  final String? addNewText;
  final void Function(String)? onAddNew;
  final String Function(T)? itemToString;

  const EnhancedCustomDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.isRequired = true,
    this.allowAddNew = true,
    this.allowClear = true,
    this.addNewText,
    this.onAddNew,
    this.itemToString,
  });

  @override
  State<EnhancedCustomDropdown<T>> createState() =>
      _EnhancedCustomDropdownState<T>();
}

class _EnhancedCustomDropdownState<T> extends State<EnhancedCustomDropdown<T>> {
  T? _selectedValue;
  final TextEditingController _addNewController = TextEditingController();
  bool _showAddNewDialog = false;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  void dispose() {
    _addNewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: _selectedValue,
          onChanged: (T? newValue) {
            if (newValue == null) {
              // Clear selection
              setState(() {
                _selectedValue = null;
              });
              widget.onChanged?.call(null);
            } else if (_isAddNewOption(newValue)) {
              // Show add new dialog
              _showAddNewDialog = true;
            } else {
              // Normal selection
              setState(() {
                _selectedValue = newValue;
              });
              widget.onChanged?.call(newValue);
            }
          },
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: Icon(
              widget.icon,
              color: Colors.grey[500],
              size: 20,
            ),
            suffixIcon: widget.allowClear && _selectedValue != null
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[500],
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedValue = null;
                      });
                      widget.onChanged?.call(null);
                    },
                  )
                : null,
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
          items: _buildDropdownItems(),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey[500],
          ),
        ),
        if (_showAddNewDialog) _buildAddNewDialog(),
      ],
    );
  }

  List<DropdownMenuItem<T>> _buildDropdownItems() {
    List<DropdownMenuItem<T>> items = [];

    // Add existing items
    for (T item in widget.items) {
      items.add(
        DropdownMenuItem<T>(
          value: item,
          child: Text(
            widget.itemToString?.call(item) ?? item.toString(),
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ),
      );
    }

    // Add "Add New" option if enabled
    if (widget.allowAddNew && widget.onAddNew != null) {
      items.add(
        DropdownMenuItem<T>(
          value: _getAddNewValue(),
          child: Row(
            children: [
              Icon(
                Icons.add,
                size: 16,
                color: const Color(0xFF1565C0),
              ),
              const SizedBox(width: 8),
              Text(
                widget.addNewText ?? 'Add New',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF1565C0),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return items;
  }

  T _getAddNewValue() {
    // Create a special value to identify "Add New" option
    // We'll use a special string that won't conflict with normal items
    return '___ADD_NEW___' as T;
  }

  bool _isAddNewOption(T? value) {
    // Check if this is the "Add New" option
    return widget.allowAddNew &&
        widget.onAddNew != null &&
        value.toString() == '___ADD_NEW___';
  }

  Widget _buildAddNewDialog() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          Text(
            'Add New ${widget.label}',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addNewController,
            decoration: InputDecoration(
              hintText: 'Enter new ${widget.label.toLowerCase()}',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color(0xFF1565C0), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            style: GoogleFonts.inter(fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _showAddNewDialog = false;
                    _addNewController.clear();
                  });
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final newValue = _addNewController.text.trim();
                  if (newValue.isNotEmpty) {
                    widget.onAddNew?.call(newValue);
                    setState(() {
                      _showAddNewDialog = false;
                      _addNewController.clear();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  'Add',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
    ];
  }

  static List<String> getWarehouses() {
    return [
      'Main Warehouse',
      'Secondary Warehouse',
      'Remote Storage',
      'Office Storage',
      'Lab Storage',
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
    ];
  }
}
