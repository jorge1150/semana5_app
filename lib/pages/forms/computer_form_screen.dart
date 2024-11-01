import 'package:flutter/material.dart';
import '../../database/computer_dao.dart';
import '../../models/computer_model.dart';

class ComputerFormScreen extends StatefulWidget {
  final Computer? computer;

  ComputerFormScreen({this.computer});

  @override
  _ComputerFormScreenState createState() => _ComputerFormScreenState();
}

class _ComputerFormScreenState extends State<ComputerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ComputerDao computerDao = ComputerDao();
  late TextEditingController _processorController;
  late TextEditingController _hardDriveController;
  late TextEditingController _ramController;

  @override
  void initState() {
    super.initState();
    _processorController =
        TextEditingController(text: widget.computer?.processor);
    _hardDriveController =
        TextEditingController(text: widget.computer?.hardDrive);
    _ramController = TextEditingController(text: widget.computer?.ram);
  }

  @override
  void dispose() {
    _processorController.dispose();
    _hardDriveController.dispose();
    _ramController.dispose();
    super.dispose();
  }

  void _saveComputer() {
    if (_formKey.currentState!.validate()) {
      final newComputer = Computer(
        id: widget.computer?.id, // Mantenemos el ID si estamos editando
        processor: _processorController.text,
        hardDrive: _hardDriveController.text,
        ram: _ramController.text,
      );

      if (widget.computer == null) {
        // Agregar nueva computadora
        computerDao.insertComputer(newComputer);
      } else {
        // Actualizar computadora existente
        computerDao.updateComputer(newComputer);
      }
      Navigator.pop(context, newComputer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.computer == null
            ? 'Agregar Computadora'
            : 'Editar Computadora'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                  controller: _processorController,
                  label: 'Procesador',
                  hint: 'Ingrese procesador',
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _hardDriveController,
                  label: 'Disco duro',
                  hint: 'Ingrese disco duro',
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _ramController,
                  label: 'RAM',
                  hint: 'Ingrese RAM',
                  isNumeric: true,
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saveComputer,
                  child: Text(
                    widget.computer == null
                        ? 'Agregar Computadora'
                        : 'Actualizar Computadora',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isNumeric = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.blue.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese $label';
        }
        if (isNumeric && int.tryParse(value) == null) {
          return 'Agregar una RAM válida';
        }
        return null;
      },
    );
  }
}
