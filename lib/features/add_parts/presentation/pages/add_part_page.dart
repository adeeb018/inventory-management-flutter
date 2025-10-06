import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_management/features/add_parts/data/repositories/add_part_repository_impl.dart';
import 'package:inventory_management/features/add_parts/domain/usecases/add_parts_usecase.dart';
import 'package:inventory_management/features/add_parts/presentation/bloc/add_part_bloc.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/presentation/ui_helper.dart';
import '../../../../shared/presentation/widgets/custom_dropdown.dart';
import '../../../../shared/presentation/widgets/custom_text_field.dart';
import '../../../../shared/presentation/widgets/custom_widgets/custom_dropdown_menu.dart';
import '../../../../shared/presentation/widgets/error_widget.dart';
import '../../domain/models/part_data/part_data.dart';

class AddPartPage extends StatefulWidget {
  const AddPartPage({super.key});

  @override
  State<AddPartPage> createState() => _AddPartPageState();
}

class _AddPartPageState extends State<AddPartPage> {
  final _formKey = GlobalKey<FormState>();
  final _internalPartNumberController = TextEditingController();
  final _manufacturerPartNumberController = TextEditingController();
  final _partCostController = TextEditingController();
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

// ignore: prefer_typing_uninitialized_variables
  late final ApiClient _apiClient;
  late final AddPartRepositoryImpl _repository;
  late final GetPartDataUseCase _getPartData;
  late final AddPartBloc _addPartBloc;

  @override
  void initState() {
    _apiClient = context.read<ApiClient>();
    _repository = AddPartRepositoryImpl(apiClient: _apiClient);
    _getPartData = GetPartDataUseCase(_repository);
    _addPartBloc = AddPartBloc(getPartDataUseCase: _getPartData);
    // _addPartBloc.add(GetPartData(partNumber: partNumber));
    super.initState();
  }

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
    // return BlocConsumer<AddPartBloc, AddPartState>(
    //   bloc: _addPartBloc,
    //   listener: (context, state) {},
    //   builder: (context, state) {
    //     if (state is PartDataLoading) {
    //       return const AddPartLoadingView();
    //     }

    //     if (state is PartDataError) {
    //       return ErrorView(message: state.message);
    //     }

    //     if (state is PartDataLoaded) {
    //       return _addPartForm();
    //     }

    //     return const SizedBox.shrink();
    //   },
    // );
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
        // child: BlocConsumer<AddPartBloc, AddPartState>(
        //   listener: (context, state) {},
        //   builder: (context, state) {
        //     if (state is PartDataLoading) {
        //       return const AddPartLoadingView();
        //     }

        //     if (state is PartDataError) {
        //       return ErrorView(message: state.message);
        //     }

        //     if (state is PartDataLoaded) {
        //       return Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           _buildFormHeader(),
        //           _buildBasicInfoSection(),
        //           _buildLocationSection(),
        //           const SizedBox(height: 32),
        //         ],
        //       );
        //     }
        //     return const SizedBox.shrink();
        //   },
        // ),
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
        _buildInternalPartNumberField(),
        const SizedBox(height: 20),
        _buildManufacturerDropdown(),
        const SizedBox(height: 20),
        _buildManufacturerPartNumberField(),
        const SizedBox(height: 20),
        _buildPartTypeDropdown(),
        const SizedBox(height: 20),
        _buildCostField(),
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
        // const SizedBox(height: 20),
        // _buildRackDropdown(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildManufacturerDropdown() {
    return BlocBuilder<AddPartBloc, AddPartState>(
      bloc: _addPartBloc,
      builder: (context, state) {
        if (state is PartDataLoaded) {
          debugPrint('state.manufacturerList ${state.manufacturerList}');
          return CustomDropdown<String>(
            label: 'Manufacturer Name',
            hint: 'Search and select Manufacturer name...',
            icon: Icons.business,
            value: _selectedManufacturer,
            items: state.manufacturerList.map<CustomDropdownMenuEntry<String>>(
                (Manufacturer manufacturer) {
              return CustomDropdownMenuEntry<String>(
                value: manufacturer.manufacturerId.toString(),
                label: manufacturer.name,
                leadingIcon: const Icon(Icons.business, size: 18),
              );
            }).toList(),
            onSelected: (String? value) {
              setState(() {
                _selectedManufacturer = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select Manufacturer name';
              }
              return null;
            },
            addItemBtnTitle: 'New Manufacturer',
            onItemBtnClicked: () {
              debugPrint('add item button clicked');
              _showAddNewDialog(context);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPartTypeDropdown() {
    // return CustomDropdown<String>(
    //   label: 'Part Type',
    //   hint: 'Select part type',
    //   icon: Icons.category,
    //   value: _selectedPartType,
    //   items: DropdownData.getPartTypes()
    //       .map<CustomDropdownMenuEntry<String>>((partType) {
    //     return CustomDropdownMenuEntry<String>(
    //       // value: partType,
    //       // child: Text(partType),
    //       value: partType,
    //       label: partType,
    //       leadingIcon: const Icon(Icons.category, size: 18),
    //     );
    //   }).toList(),
    //   onSelected: (value) {
    //     setState(() {
    //       _selectedPartType = value;
    //     });
    //   },
    //   validator: (value) {
    //     if (value == null || value.isEmpty) {
    //       return 'Please select part type';
    //     }
    //     return null;
    //   },
    //   addItemBtnTitle: 'Add Part Type',
    //   onItemBtnClicked: () {
    //     debugPrint('add item button clicked');
    //     _showAddNewDialog(context);
    //   },
    // );
    return CustomTextField(
      controller: _manufacturerPartNumberController,
      label: 'Part Type',
      hint: 'Enter part type',
      icon: Icons.category,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter part type';
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

  Widget _buildCostField() {
    return CustomTextField(
      controller: _partCostController,
      label: 'Cost',
      hint: 'Enter cost of the part',
      icon: Icons.attach_money,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please cost of the part';
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
    return BlocBuilder<AddPartBloc, AddPartState>(
      bloc: _addPartBloc,
      builder: (context, state) {
        if (state is PartDataLoaded) {
          return CustomDropdown<String>(
            label: 'Warehouse',
            hint: 'Select warehouse',
            icon: Icons.warehouse,
            value: _selectedWarehouse,
            items: state.warehouseList.map((warehouse) {
              return CustomDropdownMenuEntry<String>(
                value: warehouse.warehouseId.toString(),
                label: warehouse.warehouseName,
                leadingIcon: const Icon(Icons.warehouse, size: 18),
              );
            }).toList(),
            onSelected: (value) {
              setState(() {
                _selectedWarehouse = value;
              });
              _addPartBloc
                  .add(GetLocationList(warehouseId: _selectedWarehouse ?? ''));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select warehouse';
              }
              return null;
            },
            addItemBtnTitle: 'Add warehouse',
            onItemBtnClicked: () {
              debugPrint('add item button clicked');
              _showAddNewDialog(context);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLocationDropdown() {
    return BlocBuilder<AddPartBloc, AddPartState>(
      bloc: _addPartBloc,
      builder: (context, state) {
        if (state is PartDataLoaded) {
          return CustomDropdown<String>(
            label: 'Location',
            hint: 'Select location',
            icon: Icons.location_on,
            value: _selectedLocation,
            items: state.locationList.map((location) {
              return CustomDropdownMenuEntry<String>(
                value: location.locationId.toString(),
                label: location.locationName,
                leadingIcon: const Icon(Icons.location_on, size: 18),
              );
            }).toList(),
            onSelected: (value) {
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
            addItemBtnTitle: 'Add Location',
            onItemBtnClicked: () {
              debugPrint('add item button clicked');
              _showAddNewDialog(context);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAlternatePartNumberDropdown() {
    return CustomDropdown<String>(
      label: 'Internal Part Number',
      hint: 'Select internal part number',
      icon: Icons.swap_horiz,
      value: _selectedAlternatePartNumber,
      items: DropdownData.getAlternatePartNumbers().map((altPartNumber) {
        return CustomDropdownMenuEntry<String>(
          value: altPartNumber,
          label: altPartNumber,
          leadingIcon: const Icon(Icons.swap_horiz, size: 18),
        );
      }).toList(),
      onSelected: (value) {
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
      addItemBtnTitle: 'Add Part Number',
      onItemBtnClicked: () {
        debugPrint('add item button clicked');
        _showAddNewDialog(context);
      },
    );
  }

  Widget _buildInternalPartNumberField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextField(
            controller: _internalPartNumberController,
            label: 'Internal Part Number',
            hint: 'Enter internal part number',
            icon: Icons.tag,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter internal part number';
              }
              return null;
            },
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              _addPartBloc.add(
                  GetPartData(partNumber: _internalPartNumberController.text));
            },
            child: const Text('Submit'),
          ),
        ),
      ],
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

class AddPartLoadingView extends StatelessWidget {
  const AddPartLoadingView({super.key});

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
