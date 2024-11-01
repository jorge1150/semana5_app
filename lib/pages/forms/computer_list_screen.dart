import 'package:flutter/material.dart';
import '../../database/computer_dao.dart';
import '../../models/computer_model.dart';
import 'computer_form_screen.dart';

class ComputerListScreen extends StatefulWidget {
  @override
  _ComputerListScreenState createState() => _ComputerListScreenState();
}

class _ComputerListScreenState extends State<ComputerListScreen> {
  final ComputerDao computerDao = ComputerDao();
  List<Computer> computers = [];

  @override
  void initState() {
    super.initState();
    _loadComputers();
  }

  Future<void> _loadComputers() async {
    final loadedComputers = await computerDao.fetchComputers();
    setState(() => computers = loadedComputers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computadoras'),
        backgroundColor: Colors.blueAccent,
      ),
      body: computers.isEmpty
          ? Center(
              child:
                  Text('No se ha encontrado computadoras, presione agregar.'))
          : ListView.builder(
              itemCount: computers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      computers[index].processor,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'RAM: ${computers[index].ram} | Disco duro: ${computers[index].hardDrive}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        computerDao.deleteComputer(computers[index].id!);
                        _loadComputers();
                      },
                    ),
                    onTap: () async {
                      final updatedComputer = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComputerFormScreen(
                            computer: computers[index],
                          ),
                        ),
                      );
                      if (updatedComputer != null) {
                        _loadComputers();
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newComputer = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComputerFormScreen()),
          );
          if (newComputer != null) {
            _loadComputers();
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
