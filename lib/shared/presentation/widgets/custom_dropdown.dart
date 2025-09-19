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

// class CustomDropdown2 extends StatefulWidget {
//   final List<String> items;
//   final String? selectedItem;
//   final String hint;
//   final Function(String?) onChanged;
//   final Function(String) onNewItemAdded;
//   final bool showAddOption;
//   final String addItemText;
//   final InputDecoration? textFieldDecoration;

//   const CustomDropdown2({
//     Key? key,
//     required this.items,
//     this.selectedItem,
//     this.hint = 'Select an item',
//     required this.onChanged,
//     required this.onNewItemAdded,
//     this.showAddOption = true,
//     this.addItemText = 'Add New Item',
//     this.textFieldDecoration,
//   }) : super(key: key);

//   @override
//   State<CustomDropdown2> createState() => _CustomDropdown2State();
// }

// class _CustomDropdown2State extends State<CustomDropdown2> {
//   late List<String> _items;
//   String? _selectedItem;
//   final TextEditingController _textController = TextEditingController();
//   bool _showTextField = false;

//   @override
//   void initState() {
//     super.initState();
//     _items = List.from(widget.items);
//     _selectedItem = widget.selectedItem;
//   }

//   @override
//   void didUpdateWidget(CustomDropdown2 oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.items != oldWidget.items) {
//       _items = List.from(widget.items);
//     }
//     if (widget.selectedItem != oldWidget.selectedItem) {
//       _selectedItem = widget.selectedItem;
//     }
//   }

//   void _addNewItem() {
//     final newItem = _textController.text.trim();
//     if (newItem.isNotEmpty && !_items.contains(newItem)) {
//       setState(() {
//         _items.add(newItem);
//         _selectedItem = newItem;
//         _showTextField = false;
//         _textController.clear();
//       });
//       widget.onNewItemAdded(newItem);
//       widget.onChanged(newItem);
//     }
//   }

//   void _cancelAddItem() {
//     setState(() {
//       _showTextField = false;
//       _textController.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         DropdownButtonFormField<String>(
//           value: _selectedItem,
//           hint: Text(widget.hint),
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           ),
//           items: [
//             // Regular items
//             ..._items.map((String item) {
//               return DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(item),
//               );
//             }).toList(),
//             // Add new item option
//             if (widget.showAddOption)
//               DropdownMenuItem<String>(
//                 value: '__add_new__',
//                 child: Row(
//                   children: [
//                     const Icon(Icons.add, size: 18, color: Colors.blue),
//                     const SizedBox(width: 8),
//                     Text(
//                       widget.addItemText,
//                       style: const TextStyle(color: Colors.blue),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//           onChanged: (String? value) {
//             if (value == '__add_new__') {
//               setState(() {
//                 _showTextField = true;
//               });
//             } else {
//               setState(() {
//                 _selectedItem = value;
//               });
//               widget.onChanged(value);
//             }
//           },
//         ),
//         // Text field for adding new item
//         if (_showTextField) ...[
//           const SizedBox(height: 16),
//           Card(
//             elevation: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Add New Item',
//                     style: Theme.of(context).textTheme.titleSmall,
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: _textController,
//                     decoration: widget.textFieldDecoration ??
//                         const InputDecoration(
//                           labelText: 'Enter new item',
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 8,
//                           ),
//                         ),
//                     onSubmitted: (_) => _addNewItem(),
//                     autofocus: true,
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: _addNewItem,
//                           child: const Text('Add'),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: TextButton(
//                           onPressed: _cancelAddItem,
//                           child: const Text('Cancel'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }
// }

// class CustomDropdown2 extends StatefulWidget {
//   final List<String> items;
//   final String? selectedItem;
//   final String hint;
//   final Function(String?) onChanged;
//   final Function(String) onNewItemAdded;
//   final bool showAddOption;
//   final String addItemText;
//   final InputDecoration? textFieldDecoration;
//   final double? dropdownHeight;

//   const CustomDropdown2({
//     Key? key,
//     required this.items,
//     this.selectedItem,
//     this.hint = 'Select an item',
//     required this.onChanged,
//     required this.onNewItemAdded,
//     this.showAddOption = true,
//     this.addItemText = 'Add New Item',
//     this.textFieldDecoration,
//     this.dropdownHeight = 200,
//   }) : super(key: key);

//   @override
//   State<CustomDropdown2> createState() => _CustomDropdown2State();
// }

// class _CustomDropdown2State extends State<CustomDropdown2> {
//   late List<String> _items;
//   String? _selectedItem;
//   final TextEditingController _textController = TextEditingController();
//   bool _showTextField = false;

//   @override
//   void initState() {
//     super.initState();
//     _items = List.from(widget.items);
//     _selectedItem = widget.selectedItem;

//     // Validate that selectedItem exists in items
//     if (_selectedItem != null && !_items.contains(_selectedItem)) {
//       _selectedItem = null;
//     }
//   }

//   @override
//   void didUpdateWidget(CustomDropdown2 oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.items != oldWidget.items) {
//       _items = List.from(widget.items);
//     }

//     // Validate selected item when items change
//     if (widget.selectedItem != oldWidget.selectedItem) {
//       if (widget.selectedItem != null && _items.contains(widget.selectedItem)) {
//         _selectedItem = widget.selectedItem;
//       } else {
//         _selectedItem = null;
//       }
//     }
//   }

//   void _addNewItem() {
//     final newItem = _textController.text.trim();
//     if (newItem.isNotEmpty && !_items.contains(newItem)) {
//       setState(() {
//         _items.add(newItem);
//         _selectedItem = newItem;
//         _showTextField = false;
//         _textController.clear();
//       });
//       widget.onNewItemAdded(newItem);
//       widget.onChanged(newItem);
//     } else if (_items.contains(newItem)) {
//       // If item already exists, just select it
//       setState(() {
//         _selectedItem = newItem;
//         _showTextField = false;
//         _textController.clear();
//       });
//       widget.onChanged(newItem);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Item "$newItem" already exists and has been selected'),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   void _cancelAddItem() {
//     setState(() {
//       _showTextField = false;
//       _textController.clear();
//     });
//   }

//   void _showAddItemField() {
//     setState(() {
//       _showTextField = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Main dropdown with limited height
//         Container(
//           constraints: BoxConstraints(
//             maxHeight: widget.dropdownHeight ?? 200,
//           ),
//           child: DropdownButtonFormField<String>(
//             value: _selectedItem,
//             hint: Text(widget.hint),
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//               contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             ),
//             isExpanded: true,
//             menuMaxHeight: widget.dropdownHeight,
//             items: _items.map((String item) {
//               return DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               );
//             }).toList(),
//             onChanged: (String? value) {
//               setState(() {
//                 _selectedItem = value;
//               });
//               widget.onChanged(value);
//             },
//           ),
//         ),

//         // Add new item button - always visible
//         if (widget.showAddOption) ...[
//           const SizedBox(height: 8),
//           OutlinedButton.icon(
//             onPressed: _showTextField ? null : _showAddItemField,
//             icon: const Icon(Icons.add, size: 18),
//             label: Text(widget.addItemText),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: Colors.blue,
//               side: const BorderSide(color: Colors.blue),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             ),
//           ),
//         ],

//         // Text field for adding new item
//         if (_showTextField) ...[
//           const SizedBox(height: 12),
//           Card(
//             elevation: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Add New Item',
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: _textController,
//                     decoration: widget.textFieldDecoration ??
//                         const InputDecoration(
//                           labelText: 'Enter new item',
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 8,
//                           ),
//                         ),
//                     onSubmitted: (_) => _addNewItem(),
//                     autofocus: true,
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton.icon(
//                           onPressed: _addNewItem,
//                           icon: const Icon(Icons.check, size: 18),
//                           label: const Text('Add'),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             foregroundColor: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: TextButton.icon(
//                           onPressed: _cancelAddItem,
//                           icon: const Icon(Icons.close, size: 18),
//                           label: const Text('Cancel'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }
// }

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
