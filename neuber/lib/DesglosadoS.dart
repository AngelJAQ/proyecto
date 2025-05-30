import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

final airtableApiToken =
    'patTjJNwpD104BTKG.9352a6a8b38ce585bc3b55de8667ef8e81800fc5cde77e95a95398447a4ca604';
final airtableApiBaseUrl = 'https://api.airtable.com';
final airtableBaseId = 'appHba5WGxI7G7VDA';
final airtableTableName = 'Proyectos';

void main() => runApp(MaterialApp(home: DesglosadoSPage(linea: 'valor_linea', proyecto: 'valor_proyecto')));

class DesglosadoSPage extends StatefulWidget {
  final String linea; // Agrega el parámetro linea
  final String proyecto; // Agrega el parámetro proyecto
  const DesglosadoSPage({super.key, required this.linea, required this.proyecto}); // Actualiza el constructor

  @override
  _DesglosadoSPageState createState() => _DesglosadoSPageState();
}

class _DesglosadoSPageState extends State<DesglosadoSPage> {
  late int AvanceProyecto1, RestanteProyecto1;
  late DateTime fechaInicio, fechaEntrega;
  late String nombre;
  bool showAllGraphs = false; // Estado para controlar qué gráficas mostrar

  @override
  void initState() {
    super.initState();
    print('Valor de proyecto: ${widget.proyecto}');
    fetchAirtableData().then((data) {
      setState(() {
        AvanceProyecto1 = data[0]['AvanceProyecto1'];
        RestanteProyecto1 = data[0]['RestanteProyecto1'];
        fechaInicio = data[0]['fechaInicio'];
        fechaEntrega = data[0]['fechaEntrega'];
        nombre = data[0]['nombre'];
      });
    }).catchError((error) {
      // Maneja el error aquí
      print('Error al obtener los datos: $error');
    });
  }

  Future<List<Map<String, dynamic>>> fetchAirtableData() async {
    final response = await http.get(
      Uri.parse(
        '$airtableApiBaseUrl/v0/$airtableBaseId/$airtableTableName',
      ),
      headers: {
        'Authorization': 'Bearer $airtableApiToken',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> records = data['records'];

      List<Map<String, dynamic>> result = [];
      for (var record in records) {
        Map<String, dynamic> fields = record['fields'];

        // Filtra los registros donde la línea es "Linea 1 y 2"
        if (fields['Huacal ${widget.linea}'] == 'Verdadero') {
          int AvanceProyecto1 = fields['Huacal'];
          int RestanteProyecto1 = fields['Restante Huacal'];
          DateTime fechaInicio = fields['Fecha de inicio'] == null || fields['Fecha de inicio'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de inicio']);

          DateTime fechaEntrega = fields['Fecha de fin'] == null || fields['Fecha de fin'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de fin']);

          String nombre = 'HUACAL ${fields['Nombre del Proyecto']}';

          String nota = fields['Nota Huacal']; // Agrega esta línea

          result.add({
            'id': record['id'], // Agrega el ID del registro
            'AvanceProyecto1': AvanceProyecto1,
            'RestanteProyecto1': RestanteProyecto1,
            'fechaInicio': fechaInicio,
            'fechaEntrega': fechaEntrega,
            'nombre': nombre,
            'nota': nota, // Agrega esta línea
          });
        }
        if (fields['Cama ${widget.linea}'] == 'Verdadero') {
          int AvanceProyecto1 = fields['Cama'];
          int RestanteProyecto1 = fields['Restante Cama'];
          DateTime fechaInicio = fields['Fecha de inicio'] == null || fields['Fecha de inicio'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de inicio']);

          DateTime fechaEntrega = fields['Fecha de fin'] == null || fields['Fecha de fin'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de fin']);

          String nombre = 'CAMA ${fields['Nombre del Proyecto']}';

          String nota = fields['Nota Cama']; // Agrega esta línea

          result.add({
            'id': record['id'], // Agrega el ID del registro
            'AvanceProyecto1': AvanceProyecto1,
            'RestanteProyecto1': RestanteProyecto1,
            'fechaInicio': fechaInicio,
            'fechaEntrega': fechaEntrega,
            'nombre': nombre,
            'nota': nota, // Agrega esta línea
          });
        }

        if (fields['Interiores ${widget.linea}'] == 'Verdadero') {
          int AvanceProyecto1 = fields['Soldadura'];
          int RestanteProyecto1 = fields['Restante Soldadura'];
          DateTime fechaInicio = fields['Fecha de inicio'] == null || fields['Fecha de inicio'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de inicio']);

          DateTime fechaEntrega = fields['Fecha de fin'] == null || fields['Fecha de fin'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de fin']);

          String nombre = 'INTERIOR ${fields['Nombre del Proyecto']}';

          String nota = fields['Nota Interiores']; // Agrega esta línea

          result.add({
            'id': record['id'], // Agrega el ID del registro
            'AvanceProyecto1': AvanceProyecto1,
            'RestanteProyecto1': RestanteProyecto1,
            'fechaInicio': fechaInicio,
            'fechaEntrega': fechaEntrega,
            'nombre': nombre,
            'nota': nota, // Agrega esta línea
          });
        }

        if (fields['Patines ${widget.linea}'] == 'Verdadero') {
          int AvanceProyecto1 = fields['Patines'];
          int RestanteProyecto1 = fields['Restante Patines'];
          DateTime fechaInicio = fields['Fecha de inicio'] == null || fields['Fecha de inicio'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de inicio']);

          DateTime fechaEntrega = fields['Fecha de fin'] == null || fields['Fecha de fin'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de fin']);

          String nombre = 'PATINES ${fields['Nombre del Proyecto']}';

          String nota = fields['Nota Patines']; // Agrega esta línea

          result.add({
            'id': record['id'], // Agrega el ID del registro
            'AvanceProyecto1': AvanceProyecto1,
            'RestanteProyecto1': RestanteProyecto1,
            'fechaInicio': fechaInicio,
            'fechaEntrega': fechaEntrega,
            'nombre': nombre,
            'nota': nota, // Agrega esta línea
          });
        }

        if (fields['Soldadura ${widget.linea}'] == 'Verdadero' 
        && fields['Patines L1'] == 'Verdadero'
        && fields['Patines L2'] == 'Verdadero'
        && fields['Patines L3'] == 'Verdadero') {
          print("se guarda soldadura linea");
          
          int AvanceProyecto1 = fields['Soldadura Linea'];
          int RestanteProyecto1 = fields['Restante Soldadura Linea'];
          DateTime fechaInicio = fields['Fecha de inicio'] == null || fields['Fecha de inicio'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de inicio']);

          DateTime fechaEntrega = fields['Fecha de fin'] == null || fields['Fecha de fin'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de fin']);

          String nombre = 'SOLDADURA ${fields['Nombre del Proyecto']}';

          String nota = fields['Nota Soldadura Linea']; // Agrega esta línea

          result.add({
            'id': record['id'], // Agrega el ID del registro
            'AvanceProyecto1': AvanceProyecto1,
            'RestanteProyecto1': RestanteProyecto1,
            'fechaInicio': fechaInicio,
            'fechaEntrega': fechaEntrega,
            'nombre': nombre,
            'nota': nota, // Agrega esta línea
          });
        }

         if (fields['Soldadura ${widget.linea}'] == 'Verdadero' 
        && fields['Patines L1'] == 'Falso'
        && fields['Patines L2'] == 'Falso'
        && fields['Patines L3'] == 'Falso') {
          print("no se guarda soldadura linea");
          
          int AvanceProyecto1 = fields['Avance Soldadura ${widget.linea}'];
          int RestanteProyecto1 = fields['Restante Soldadura ${widget.linea}'];
          DateTime fechaInicio = fields['Fecha de inicio'] == null || fields['Fecha de inicio'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de inicio']);

          DateTime fechaEntrega = fields['Fecha de fin'] == null || fields['Fecha de fin'].isEmpty
              ? DateTime.now() // O cualquier otro valor predeterminado que desees
              : DateTime.parse(fields['Fecha de fin']);

          String nombre = 'SOLDADURA ${fields['Nombre del Proyecto']}';

          String nota = fields['Nota Soldadura Linea']; // Agrega esta línea

          result.add({
            'id': record['id'], // Agrega el ID del registro
            'AvanceProyecto1': AvanceProyecto1,
            'RestanteProyecto1': RestanteProyecto1,
            'fechaInicio': fechaInicio,
            'fechaEntrega': fechaEntrega,
            'nombre': nombre,
            'nota': nota, // Agrega esta línea
          });
        }
      }

      result.sort((a, b) => a['nombre'].compareTo(b['nombre']));

      // Filtrar los resultados por el nombre del proyecto
      result = result.where((element) => element['nombre'].contains(widget.proyecto)).toList();

      return result;
    } else {
      throw Exception('Failed to load data from Airtable');
    }
  }

@override
Widget build(BuildContext context) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: fetchAirtableData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(
          height: 60.0,
          width: 60.0,
          child: SpinKitFadingCircle(
            color: Colors.black,
            size: 60.0,
          ),
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        if (snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  size: 100,
                  color: Colors.grey,
                ),
                Text(
                  'No se encontraron proyectos en línea',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    decoration: TextDecoration.none, // Elimina el subrayado
                  ),
                ),
              ],
            ),
          );
        } else {
          return _buildGraph(snapshot.data!);
        }
      }
    },
  );
}

Widget _buildGraph(List<Map<String, dynamic>> data) {

  List<Widget> charts = [];

  for (var record in data) {
    int avanceProyecto1 = record['AvanceProyecto1'];
    int restanteProyecto1 = record['RestanteProyecto1'];
    DateTime fechaInicio = record['fechaInicio'];
    DateTime fechaEntrega = record['fechaEntrega'];
    String nombre = record['nombre'];

    // Controlar si se deben mostrar todas las gráficas o solo las que tienen restante diferente de cero
    if (showAllGraphs || restanteProyecto1 != 0) {
      charts.add(_buildPieChart(
        context,
        nombre,
        avanceProyecto1,
        restanteProyecto1,
        record,
        onPressed: () {},
        customOnPressed: () {
          _showCustomInfoDialog(
            context,
            title: 'Info ',
            projectData: record,
          );
        },
        cardHeight: 500,
        cardWidth: 300,
        fechaInicio: fechaInicio,
        fechaEntrega: fechaEntrega,
        targetPage: 'Proyecto1Page',
      ));
    }
  }

  return Scaffold(
    backgroundColor: Color(0xFFe5ecf4),
    appBar: AppBar(
      title: Text(
        'Proyecto',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xFF313745),
      actions: [
        IconButton(
          icon: Icon(Icons.remove_red_eye, color: Colors.green), // Icono de ojo verde
          onPressed: () {
            setState(() {
              showAllGraphs = true; // Mostrar todas las gráficas
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.remove_red_eye_outlined, color: Colors.red), // Icono de ojo rojo
          onPressed: () {
            setState(() {
              showAllGraphs = false; // Mostrar solo gráficas con restante diferente de cero
            });
          },
        ),
      ],
    ),
    body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isPortrait = constraints.maxHeight > constraints.maxWidth;
        int crossAxisCount = isPortrait ? 1 : 3;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: charts.length,
          itemBuilder: (context, index) {
            return charts[index];
          },
        );
      },
    ),
  );
}

DateTime _getFechaInicio(String fechaInicio) {
 return DateTime.parse(fechaInicio);
}

DateTime _getFechaEntrega(String fechaEntrega) {
 return DateTime.parse(fechaEntrega);
}

Widget _buildPieChart(
  BuildContext context,
  String title,
  int value1, // Avance
  int value2, // Restante
  Map<String, dynamic> data,
  {
    required VoidCallback onPressed,
    VoidCallback? customOnPressed,
    required double cardHeight,
    required double cardWidth,
    required DateTime fechaInicio,
    required DateTime fechaEntrega,
    required String targetPage,
  }
) {
  DateTime fechaInicio0 = fechaInicio;
  DateTime fechaEntrega0 = fechaEntrega;
  DateTime fechaActual = DateTime.now();

  Color circleColor;
  if (fechaActual.isBefore(fechaInicio)) {
    circleColor = Colors.blue; // Si es antes de la fecha de inicio, gris
  } else if (fechaActual.isBefore(fechaEntrega.subtract(Duration(days: 7)))) {
    circleColor = Colors.green; // Si falta más de una semana, verde
  } else if (fechaActual.isBefore(fechaEntrega)) {
    circleColor = Colors.yellow; // Si falta una semana o menos, amarillo
  } else {
    circleColor = Colors.red; // Si ya pasó la fecha de entrega, rojo
  }

  double screenWidth = MediaQuery.of(context).size.width;
  double textScaleFactor = screenWidth / 950;
  double iconScaleFactor = screenWidth / 950;

  double total = value1.toDouble() + value2.toDouble();
  
  // Asegurarse de que el total no sea cero
  if (total == 0) {
    total = 0.001; // Asignar un valor pequeño para evitar la división por cero
  }

  double percentage1 = (value1.toDouble() / total) * 100;

  double initialChartSize = 16;
  double maxChartSize = 55.0;
  double minChartSize = 40.0;
  double radius = initialChartSize * screenWidth / 375;

  double titleFontSize = 24 * textScaleFactor;
  double minTitleFontSize = 16.0;
  titleFontSize = titleFontSize.clamp(minTitleFontSize, double.infinity);

  double labelTextFontSize = 16 * textScaleFactor;
  double minTextFontSize = 12.0;
  labelTextFontSize = labelTextFontSize.clamp(minTextFontSize, double.infinity);

  if (radius > maxChartSize) {
    radius = maxChartSize;
  } else if (radius < minChartSize) {
    radius = minChartSize;
  }

  double calculateIconSize(double iconScaleFactor) {
    double initialIconSize = 40;
    double maxIconSize = 40;
    double minIconSize = 25;

    double iconSize = initialIconSize * iconScaleFactor;
    iconSize = iconSize.clamp(minIconSize, maxIconSize);

    return iconSize;
  }

  List<PieChartSectionData> sections = [];

// Sección para el Avance (value1)
if (value1 > 0) {
  sections.add(
    PieChartSectionData(
      value: value1.toDouble(),
      color: Colors.green,
      title: '$value1',
      radius: radius * 1,
    ),
  );
} else {
  // Si value1 es 0, agregar una sección mínima para mantener el formato de anillo
  sections.add(
    PieChartSectionData(
      value: 1, // Valor muy pequeño para mantener el formato de anillo
      color: Colors.red,
      title: '0', // Mostrar '0' en lugar de 1
      radius: radius * 1,
    ),
  );
}

// Sección para el Restante (value2)
if (value2 > 0) {
  sections.add(
    PieChartSectionData(
      value: value2.toDouble(),
      color: Colors.red,
      title: '$value2',
      radius: radius * 1,
    ),
  );
} else {
  // Si value2 es 0, agregar una sección mínima para mantener el formato de anillo
  sections.add(
    PieChartSectionData(
      value: 1, // Valor muy pequeño para mantener el formato de anillo
      color: Colors.green,
      title: '0', // Mostrar '0' en lugar de 1
      radius: radius * 1,
    ),
  );
}


  return Material(
    child: InkWell(
      onTap: () {
      },
      onLongPress: () {
        _showDetailDialog(context, data);
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: SizedBox(
          height: cardHeight,
          width: cardWidth,
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    _showDaysRemainingDialog(fechaEntrega);
                  },
                  child: Container(
                    width: 30,
                    height: 30 * textScaleFactor,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circleColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            title,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.info, size: calculateIconSize(iconScaleFactor)),
                              onPressed: customOnPressed ?? onPressed,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                              sections: sections,
                              centerSpaceRadius: radius * .9,
                              sectionsSpace: 0,
                            ),
                          ),
                          Positioned.fill(
                            child: Center(
                              child: Text(
                                '${percentage1.toStringAsFixed(2)}%',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16 * textScaleFactor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (value1 > 0)
                          Text(
                            'Total ',
                            style: TextStyle(
                              fontSize: labelTextFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (value1 > 0)
                          Container(
                            width: 20 * textScaleFactor,
                            height: 20 * textScaleFactor,
                            color: Colors.green,
                          ),
                        if (value2 > 0)
                          Text(
                            '          Restante ',
                            style: TextStyle(
                              fontSize: labelTextFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (value2 > 0)
                          Container(
                            width: 20 * textScaleFactor,
                            height: 20 * textScaleFactor,
                            color: Colors.red,
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Fecha de Inicio ${fechaInicio0.day}/${fechaInicio0.month}/${fechaInicio0.year}',
                      style: TextStyle(
                        fontSize: labelTextFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Fecha de Entrega ${fechaEntrega0.day}/${fechaEntrega0.month}/${fechaEntrega0.year}',
                      style: TextStyle(
                        fontSize: labelTextFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> updateAirtableRecord(String id, Map<String, dynamic> fields) async {
 final response = await http.patch(
   Uri.parse('$airtableApiBaseUrl/v0/$airtableBaseId/$airtableTableName/$id'),
   headers: {
     'Authorization': 'Bearer $airtableApiToken',
     'Content-type': 'application/json',
   },
   body: jsonEncode({
     'fields': fields,
   }),
 );

 if (response.statusCode != 200) {
   throw Exception('Failed to update record: ${response.body}');
 }
}

void _showEditDialog(BuildContext context, Map<String, dynamic> data) {
  int restanteSoldadura = data['RestanteProyecto1'];
  int piezasTerminadas = 0;

  TextEditingController textFieldController = TextEditingController();

  ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

  // Verifica si el tipo de proyecto es HUACAL antes de mostrar el diálogo
  if (data['nombre'].startsWith('HUACAL')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Piezas Terminadas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: (piezasTerminadas > restanteSoldadura)
                      ? 'El valor no puede ser mayor '
                      : null,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    int parsedValue = int.tryParse(value) ?? 0;
                    piezasTerminadas = parsedValue;
                  } else {
                    piezasTerminadas = 0;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                if (piezasTerminadas <= restanteSoldadura) {
                  int avanceProyecto1 = data['AvanceProyecto1'] + piezasTerminadas;
                  int restanteProyecto1 = data['RestanteProyecto1'] - piezasTerminadas;

                  // Validar que Soldadura no sea negativo
                  if (avanceProyecto1 >= 0) {
                    Navigator.of(context).pop();
                    _showUpdatedDialog(context, data, avanceProyecto1, restanteProyecto1);

                    // Actualiza el registro en Airtable
                    updateAirtableRecord(data['id'], {
                      'Huacal': avanceProyecto1,
                      'Restante Huacal': restanteProyecto1,
                    });
                  } else {
                    // Muestra un SnackBar con el mensaje de error
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('El valor ingresado hace que el valor sea negativo.'),
                      ),
                    );
                  }
                } else {
                  // Muestra un SnackBar con el mensaje de error
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('El valor no puede ser mayor al real'),
                    ),
                  );
                }
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  if (data['nombre'].startsWith('CAMA')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Piezas Terminadas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: (piezasTerminadas > restanteSoldadura)
                      ? 'El valor no puede ser mayor '
                      : null,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    int parsedValue = int.tryParse(value) ?? 0;
                    piezasTerminadas = parsedValue;
                  } else {
                    piezasTerminadas = 0;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                if (piezasTerminadas <= restanteSoldadura) {
                  int avanceProyecto1 = data['AvanceProyecto1'] + piezasTerminadas;
                  int restanteProyecto1 = data['RestanteProyecto1'] - piezasTerminadas;

                  // Validar que Soldadura no sea negativo
                  if (avanceProyecto1 >= 0) {
                    Navigator.of(context).pop();
                    _showUpdatedDialog(context, data, avanceProyecto1, restanteProyecto1);

                    // Actualiza el registro en Airtable
                    updateAirtableRecord(data['id'], {
                      'Cama': avanceProyecto1,
                      'Restante Cama': restanteProyecto1,
                    });
                  } else {
                    // Muestra un SnackBar con el mensaje de error
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('El valor ingresado hace que el valor sea negativo.'),
                      ),
                    );
                  }
                } else {
                  // Muestra un SnackBar con el mensaje de error
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('El valor no puede ser mayor al real'),
                    ),
                  );
                }
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  if (data['nombre'].startsWith('PATINES')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Piezas Terminadas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: (piezasTerminadas > restanteSoldadura)
                      ? 'El valor no puede ser mayor '
                      : null,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    int parsedValue = int.tryParse(value) ?? 0;
                    piezasTerminadas = parsedValue;
                  } else {
                    piezasTerminadas = 0;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                if (piezasTerminadas <= restanteSoldadura) {
                  int avanceProyecto1 = data['AvanceProyecto1'] + piezasTerminadas;
                  int restanteProyecto1 = data['RestanteProyecto1'] - piezasTerminadas;

                  // Validar que Soldadura no sea negativo
                  if (avanceProyecto1 >= 0) {
                    Navigator.of(context).pop();
                    _showUpdatedDialog(context, data, avanceProyecto1, restanteProyecto1);

                    // Actualiza el registro en Airtable
                    updateAirtableRecord(data['id'], {
                      'Patines': avanceProyecto1,
                      'Restante Patines': restanteProyecto1,
                    });
                  } else {
                    // Muestra un SnackBar con el mensaje de error
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('El valor ingresado hace que el valor sea negativo.'),
                      ),
                    );
                  }
                } else {
                  // Muestra un SnackBar con el mensaje de error
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('El valor no puede ser mayor al real'),
                    ),
                  );
                }
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  if (data['nombre'].startsWith('INTERIOR')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Piezas Terminadas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: (piezasTerminadas > restanteSoldadura)
                      ? 'El valor no puede ser mayor '
                      : null,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    int parsedValue = int.tryParse(value) ?? 0;
                    piezasTerminadas = parsedValue;
                  } else {
                    piezasTerminadas = 0;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                if (piezasTerminadas <= restanteSoldadura) {
                  int avanceProyecto1 = data['AvanceProyecto1'] + piezasTerminadas;
                  int restanteProyecto1 = data['RestanteProyecto1'] - piezasTerminadas;

                  // Validar que Soldadura no sea negativo
                  if (avanceProyecto1 >= 0) {
                    Navigator.of(context).pop();
                    _showUpdatedDialog(context, data, avanceProyecto1, restanteProyecto1);

                    // Actualiza el registro en Airtable
                    updateAirtableRecord(data['id'], {
                      'Soldadura Linea': avanceProyecto1,
                      'Restante Soldadura Linea': restanteProyecto1,
                    });
                  } else {
                    // Muestra un SnackBar con el mensaje de error
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('El valor ingresado hace que el valor sea negativo.'),
                      ),
                    );
                  }
                } else {
                  // Muestra un SnackBar con el mensaje de error
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('El valor no puede ser mayor al real'),
                    ),
                  );
                }
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  if (data['nombre'].startsWith('SOLDADURA')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Piezas Terminadas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: (piezasTerminadas > restanteSoldadura)
                      ? 'El valor no puede ser mayor '
                      : null,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    int parsedValue = int.tryParse(value) ?? 0;
                    piezasTerminadas = parsedValue;
                  } else {
                    piezasTerminadas = 0;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                if (piezasTerminadas <= restanteSoldadura) {
                  int avanceProyecto1 = data['AvanceProyecto1'] + piezasTerminadas;
                  int restanteProyecto1 = data['RestanteProyecto1'] - piezasTerminadas;

                  // Validar que Soldadura no sea negativo
                  if (avanceProyecto1 >= 0) {
                    Navigator.of(context).pop();
                    _showUpdatedDialog(context, data, avanceProyecto1, restanteProyecto1);

                    // Actualiza el registro en Airtable
                    updateAirtableRecord(data['id'], {
                      'Avance Soldadura ${widget.linea}': avanceProyecto1,
                      'Restante Soldadura ${widget.linea}': restanteProyecto1,
                      'Soldadura': avanceProyecto1,
                      'Restante Soldadura': restanteProyecto1,
                    });
                  } else {
                    // Muestra un SnackBar con el mensaje de error
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('El valor ingresado hace que el valor sea negativo.'),
                      ),
                    );
                  }
                } else {
                  // Muestra un SnackBar con el mensaje de error
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('El valor no puede ser mayor al real'),
                    ),
                  );
                }
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } else {
    // Si el proyecto no es de tipo HUACAL, muestra un mensaje o realiza otra acción
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Esta funcionalidad no está disponible'),
      ),
    );
  }
}

void _showLoginDialog(BuildContext context, Map<String, dynamic> data) {
  print('Valor de Linea es ${widget.linea}'); // Imprime el valor de widget.linea

  String username='';
  String password='';

  if (widget.linea == 'L1') {
    username = 'xochimitl';
    password = '6905';
  } else if (widget.linea == 'L2') {
    username = 'victor';
    password = '0504';
  } else if (widget.linea == 'L3') {
    username = 'enrique';
    password = '0619';
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Iniciar Sesión'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Usuario'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Iniciar Sesión'),
            onPressed: () {
              String inputUsername = usernameController.text;
              String inputPassword = passwordController.text;

              // Comprueba las credenciales aquí
              if (inputUsername == username && inputPassword == password) {
                Navigator.of(context).pop();
                _showEditDialog(context, data);
              } else {
                // Muestra un mensaje de error si las credenciales son incorrectas
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Usuario o contraseña incorrectos')),
                );
              }
            },
          ),
        ],
      );
    },
  );
}

void _showLoginDialogNota(BuildContext context, Map<String, dynamic> data) {
  print('Valor de Linea es ${widget.linea}'); // Imprime el valor de widget.linea

  // Obtiene el nombre real del proyecto del campo 'Nombre del Proyecto'
  String projectName = data['nombre'];
  print('Nombre real del proyecto: $projectName');

  String username='';
  String password='';

  // Asigna el username y password según el valor de widget.linea
  if (widget.linea == 'L1') {
    username = 'xochimitl';
    password = '6905';
  } else if (widget.linea == 'L2') {
    username = 'victor';
    password = '0504';
  } else if (widget.linea == 'L3') {
    username = 'enrique';
    password = '0619';
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Iniciar Sesión'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Usuario'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Iniciar Sesión'),
            onPressed: () {
              String inputUsername = usernameController.text;
              String inputPassword = passwordController.text;

              // Comprueba las credenciales aquí
              if (inputUsername == username && inputPassword == password) {
  Navigator.of(context).pop();

  // Determina el tipo de proyecto y asigna la celda de nota correspondiente
  String notaCell='';
  if (projectName.startsWith('HUACAL')) {
    notaCell = 'Nota Huacal';
  } else if (projectName.startsWith('CAMA')) {
    notaCell = 'Nota Cama';
  } else if (projectName.startsWith('SOLDADURA')) {
    notaCell = 'Nota Soldadura Linea';
    } else if (projectName.startsWith('PATINES')) {
    notaCell = 'Nota Patines';
  } else if (projectName.startsWith('INTERIOR')) {
    notaCell = 'Nota Interiores';
    
  }

  _showEditInfoDialog(context, data['id'], notaCell);
}
 else {
                // Muestra un mensaje de error si las credenciales son incorrectas
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Usuario o contraseña incorrectos')),
                );
              }
            },
          ),
        ],
      );
    },
  );
}

void _showDetailDialog(BuildContext context, Map<String, dynamic> data) {
 showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Detalles de la Gráfica'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Nombre: ${data['nombre']}'),
            Text('Avance: ${data['AvanceProyecto1']}'),
            Text('Restante: ${data['RestanteProyecto1']}'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
 child: Text('Editar'),
 onPressed: () {
   Navigator.of(context).pop();
   _showLoginDialog(context, data);
 },
),

        TextButton(
          child: Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
 );
}

void _showUpdatedDialog(BuildContext context, Map<String, dynamic> data, int avanceProyecto1, int restanteProyecto1) {
 showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Gráfica Actualizada'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Nombre: ${data['nombre']}'),
            Text('Avance: $avanceProyecto1'),
            Text('Restante: $restanteProyecto1'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
 );
}

void _showDaysRemainingDialog(DateTime fechaEntrega) {
    DateTime fechaActual = DateTime.now();
    int daysRemaining = fechaEntrega.difference(fechaActual).inDays;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Días Restantes'),
          content: Text('Faltan $daysRemaining días para la entrega.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

void _showCustomInfoDialog(BuildContext context, {required String title, required Map<String, dynamic> projectData}) {
 showDialog(
   context: context,
   builder: (BuildContext context) {
     return AlertDialog(
       title: Text(title),
       content: Text('Nota: ${projectData['nota']}'), // Muestra la información de la celda "Nota"
       actions: [
         TextButton(
           onPressed: () {
             Navigator.of(context).pop();
             _showLoginDialogNota(context, projectData); // Call _showLoginDialogNota here
           },
           child: Text('Editar'),
         ),
         TextButton(
           onPressed: () {
             Navigator.of(context).pop();
           },
           child: Text('Cerrar'),
         ),
       ],
     );
   },
 );
}

void _showEditInfoDialog(BuildContext context, String recordId, String notaFieldName) {
  TextEditingController textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar Nota'),
        content: TextField(
          controller: textController,
          maxLines: null,
          expands: true,
          decoration: InputDecoration(hintText: 'Escribe un texto aquí'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
               String newNote = textController.text;
              // Append the current date to the note
              DateFormat formatter = DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(DateTime.now());
              newNote += '\n\nFecha: $formattedDate \nEditado por: Encargado Linea';
              Navigator.of(context).pop();

              // Actualiza el registro en Airtable
              await updateAirtableRecord(recordId, {notaFieldName: newNote});

            },
            
            child: Text('Aceptar'),
            
          ),
        ],
      );
      
    },
    
  );
}


}