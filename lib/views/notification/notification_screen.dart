import 'package:flutter/material.dart';
import 'package:powersync/powersync.dart' as powersync;
import '../../../powersync.dart' show db;

class PowerSyncDebugPage extends StatefulWidget {
  const PowerSyncDebugPage({Key? key}) : super(key: key);

  @override
  State<PowerSyncDebugPage> createState() => _PowerSyncDebugPageState();
}

class _PowerSyncDebugPageState extends State<PowerSyncDebugPage> {
  List<String> _tables = [];
  String? _selectedTable;
  Stream<List<Map<String, dynamic>>>? _tableDataStream;

  @override
  void initState() {
    super.initState();
    _loadTables();
  }

  Future<void> _loadTables() async {
    final schema = db.schema;
    setState(() {
      _tables = schema.tables.map((table) => table.name).toList();
    });
  }

  void _loadTableData(String tableName) {
    setState(() {
      _selectedTable = tableName;
      _tableDataStream = db.watch('SELECT * FROM $tableName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PowerSync Debug'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (_selectedTable != null) {
                _loadTableData(_selectedTable!);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Sync Status
          StreamBuilder<powersync.SyncStatus>(
            stream: db.statusStream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sync Status: ${snapshot.data?.toString() ?? 'Unknown'}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Select a table'),
              value: _selectedTable,
              items: _tables.map((String table) {
                return DropdownMenuItem<String>(
                  value: table,
                  child: Text(table),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _loadTableData(newValue);
                }
              },
            ),
          ),
          Expanded(
            child: _tableDataStream == null
                ? const Center(
                    child: Text('Select a table to view its data'),
                  )
                : StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _tableDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final tableData = snapshot.data!;

                      if (tableData.isEmpty) {
                        return const Center(
                          child: Text('No data in table'),
                        );
                      }

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: tableData.first.keys
                                .map((key) => DataColumn(label: Text(key)))
                                .toList(),
                            rows: tableData.map((row) {
                              return DataRow(
                                cells: row.values
                                    .map((value) => DataCell(
                                          Text(value?.toString() ?? 'null'),
                                        ))
                                    .toList(),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
