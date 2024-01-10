import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detailedView.dart';

// Pantalla list animals
class ListAnimals extends StatefulWidget {
  @override
  _ListAnimalsState createState() => _ListAnimalsState();
}

class _ListAnimalsState extends State<ListAnimals> {
  List<dynamic> animalData = []; // List dinamica info api animals
  //String errorMessage = "";
  // Peticio api  (fetch)
  Future<void> _fetchAnimalsData(String name) async {
    const String apiKey = 'lDB4laXCGfgMlvOQauOfpA==nNBrvyTJXNAx0Jch';

    // Obtenir informacio de la api
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/animals?name=$name'),
      headers: {'X-Api-Key': apiKey},
    );

    // Guardar la informacio correcte
    if (response.statusCode == 200) {
      setState(() {
        animalData = json.decode(response.body);
      });
    } else {
      // Controlar error busqueda
      //errorMessage = ('Error al cargar los datos: ${response.statusCode}');
    }

    // Controlar busqueda no trobada
    if (animalData.isEmpty){
      setState(() {
        animalData = ['Not found'];
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Animals'),
      ),
      body: SingleChildScrollView( // Controla el resize dels elements child
        child: Column(
          children: [
            // Buscador
            Padding(
              padding: const EdgeInsets.all(30.0),
              // Contenidor (rectangle) pel buscador
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue[900]?.withOpacity(0.7),
                ),
                // Interior del buscador
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  // Icono buscador i text inicial
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 6.0),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter search name',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                            border: InputBorder.none,
                          ),
                          // Petició a la API segons la busqueda
                          onChanged: (value) {
                            if (value == '') {
                              setState(() {
                                animalData = [];
                              });
                            } else {
                              _fetchAnimalsData(value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // LListat Animals
            if (animalData.isEmpty) // Busqueda per iniciar
              Center(
                // Text i imatge inicial
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'WELCOME to AnimalsPotter, \n search your spotted animal!',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20), // Espai entre text i imatge
                    Image.asset(
                      'lib/assets/animalspotter.png',
                      width: 300,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),

            // Mostrar llistat animals segons la busqueda
            if (animalData.isNotEmpty)
              ListView.builder(
                // Propietats listView en SingleChildScrollView, ajusten el contingut
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // Elements de la ListView
                itemCount: animalData.length,
                // Widget amb la informacio de l'animal buscat a la API
                itemBuilder: (context, index) {
                  // Animal No trobat
                  if (animalData[index] == 'Not found') {
                    // ListTile per afegir el missatge
                    return ListTile(
                      // Mostrar imatge i missatge no trobat
                      title: Row(
                        children: [
                          Image.asset(
                            'lib/assets/notFound.png',
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                          Text('OOPS! \n Not found!',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  // Animal trobat, mostrem llista
                  final animal = animalData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    // Recuadre de cada element
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.grey[200],
                      ),
                      // Informació obtinguda de la API
                      child: ListTile(
                        title: Text(
                          animal['name'] ?? 'Name not available',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        subtitle:  Text(
                          animal['taxonomy']['scientific_name'] ?? 'Not available',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        onTap: () {
                          // Navegacio a la detailedView de l'element pulsat
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => detailedView(animal: animal),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}