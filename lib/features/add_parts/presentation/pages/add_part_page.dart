import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/presentation/ui_helper.dart';
import '../../../../shared/presentation/widgets/custom_dropdown.dart';
import '../../../../shared/presentation/widgets/custom_text_field.dart';
import '../../../../shared/presentation/widgets/custom_widgets/custom_dropdown_menu.dart';

class AddPartPage extends StatefulWidget {
  const AddPartPage({super.key});

  @override
  State<AddPartPage> createState() => _AddPartPageState();
}

class _AddPartPageState extends State<AddPartPage> {
  final _formKey = GlobalKey<FormState>();
  final _manufacturerPartNumberController = TextEditingController();
  final _currentStockController = TextEditingController();
  final _descriptionController = TextEditingController();
  final TextEditingController _newItemController = TextEditingController();

  // Dropdown values
  String? _selectedManufacturer;
  String? _selectedPartType;
  String? _selectedWarehouse;
  String? _selectedLocation;
  String? _selectedRack;
  String? _selectedAlternatePartNumber;

  @override
  void dispose() {
    _manufacturerPartNumberController.dispose();
    _currentStockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _appBar(context),
      body: _scaffoldBody(),
      bottomNavigationBar: _bottomNavigationBar(),
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
        'Add New Part',
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

  Widget _scaffoldBody() {
    return _addPartForm();
  }

  SingleChildScrollView _addPartForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
          16, 16, 16, 120), // Extra bottom padding for bottom nav
      child: _formCard(),
    );
  }

  Widget _formCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: cardDecoration(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormHeader(),
            _buildBasicInfoSection(),
            _buildLocationSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFormHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Part Information',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildManufacturerDropdown(),
        const SizedBox(height: 20),
        _buildPartTypeDropdown(),
        const SizedBox(height: 20),
        _buildManufacturerPartNumberField(),
        const SizedBox(height: 20),
        _buildCurrentStockField(),
        const SizedBox(height: 20),
        _buildDescriptionField(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWarehouseDropdown(),
        const SizedBox(height: 20),
        _buildLocationDropdown(),
        const SizedBox(height: 20),
        _buildRackDropdown(),
        const SizedBox(height: 20),
        _buildAlternatePartNumberDropdown(),
      ],
    );
  }

  Widget _buildManufacturerDropdown() {
    // return EnhancedCustomDropdown<String>(
    //   label: 'Manufacturer Name',
    //   hint: 'Select manufacturer',
    //   icon: Icons.business,
    //   value: _selectedManufacturer,
    //   items: DropdownData.getManufacturers(),
    //   onChanged: (value) {
    //     setState(() {
    //       _selectedManufacturer = value;
    //     });
    //   },
    //   onAddNew: (newManufacturer) {
    //     // Add new manufacturer to the list
    //     setState(() {
    //       _selectedManufacturer = newManufacturer;
    //     });
    //     // In a real app, you would save this to your data source
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Added new manufacturer: $newManufacturer'),
    //         backgroundColor: Colors.green,
    //         behavior: SnackBarBehavior.floating,
    //       ),
    //     );
    //   },
    //   validator: (value) {
    //     if (value == null || value.isEmpty) {
    //       return 'Please select manufacturer';
    //     }
    //     return null;
    //   },
    // );
    return CustomDropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 32,
      menuHeight: 200,
      hintText: 'Search and select part type...',
      leadingIcon: const Icon(Icons.category),
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
      onSelected: (String? value) {
        setState(() {
          _selectedManufacturer = value;
        });
      },
      addItemBtnTitle: 'New Manufacturer',
      onItemBtnClicked: () {
        debugPrint('add item button clicked');
        _showAddNewDialog(context);
      },
      dropdownMenuEntries: DropdownData.getPartTypes()
          .map<CustomDropdownMenuEntry<String>>((String partType) {
        return CustomDropdownMenuEntry<String>(
          value: partType,
          label: partType,
          leadingIcon: const Icon(Icons.widgets, size: 18),
        );
      }).toList(),
    );
  }

  Widget _buildPartTypeDropdown() {
    return EnhancedCustomDropdown<String>(
      label: 'Part Type',
      hint: 'Select part type',
      icon: Icons.category,
      value: _selectedPartType,
      items: DropdownData.getPartTypes(),
      onChanged: (value) {
        setState(() {
          _selectedPartType = value;
        });
      },
      onAddNew: (newPartType) {
        // Add new part type to the list
        setState(() {
          _selectedPartType = newPartType;
        });
        // In a real app, you would save this to your data source
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added new part type: $newPartType'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select part type';
        }
        return null;
      },
    );
  }

  Widget _buildManufacturerPartNumberField() {
    return CustomTextField(
      controller: _manufacturerPartNumberController,
      label: 'Manufacturer Part Number',
      hint: 'Enter manufacturer part number',
      icon: Icons.tag,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter manufacturer part number';
        }
        return null;
      },
    );
  }

  Widget _buildCurrentStockField() {
    return CustomTextField(
      controller: _currentStockController,
      label: 'Current Stock',
      hint: 'Enter current stock quantity',
      icon: Icons.inventory,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter current stock';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return CustomTextField(
      controller: _descriptionController,
      label: 'Description',
      hint: 'Enter part description',
      icon: Icons.description,
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter description';
        }
        return null;
      },
    );
  }

  Widget _buildWarehouseDropdown() {
    return CustomDropdown<String>(
      label: 'Warehouse',
      hint: 'Select warehouse',
      icon: Icons.warehouse,
      value: _selectedWarehouse,
      items: DropdownData.getWarehouses().map((warehouse) {
        return DropdownMenuItem<String>(
          value: warehouse,
          child: Text(warehouse),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedWarehouse = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select warehouse';
        }
        return null;
      },
    );
  }

  Widget _buildLocationDropdown() {
    return CustomDropdown<String>(
      label: 'Location',
      hint: 'Select location',
      icon: Icons.location_on,
      value: _selectedLocation,
      items: DropdownData.getLocations().map((location) {
        return DropdownMenuItem<String>(
          value: location,
          child: Text(location),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedLocation = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select location';
        }
        return null;
      },
    );
  }

  Widget _buildRackDropdown() {
    return CustomDropdown<String>(
      label: 'Rack',
      hint: 'Select rack',
      icon: Icons.view_module,
      value: _selectedRack,
      items: DropdownData.getRacks().map((rack) {
        return DropdownMenuItem<String>(
          value: rack,
          child: Text(rack),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedRack = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select rack';
        }
        return null;
      },
    );
  }

  Widget _buildAlternatePartNumberDropdown() {
    return CustomDropdown<String>(
      label: 'Alternate Part Number',
      hint: 'Select alternate part number',
      icon: Icons.swap_horiz,
      value: _selectedAlternatePartNumber,
      items: DropdownData.getAlternatePartNumbers().map((altPartNumber) {
        return DropdownMenuItem<String>(
          value: altPartNumber,
          child: Text(altPartNumber),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedAlternatePartNumber = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select alternate part number';
        }
        return null;
      },
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            _buildCancelButton(),
            const SizedBox(width: 16),
            _buildAddPartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return OutlinedButton(
      onPressed: () => context.go('/parts'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Cancel',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildAddPartButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1565C0),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Text(
        'Add Part',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Part added successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.go('/parts');
    }
  }

  void _showAddNewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            controller: _newItemController,
            decoration: const InputDecoration(
              hintText: 'Enter item name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close popup
                _newItemController.clear();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final String value = _newItemController.text.trim();
                if (value.isNotEmpty) {
                  // 🔹 Here you can add logic to save the item
                  // and maybe automatically select it.
                  print('Saved & Selected: $value');
                }
                Navigator.of(context).pop(); // close popup
                _newItemController.clear();
              },
              child: const Text('Save & Select'),
            ),
          ],
        );
      },
    );
  }
}
