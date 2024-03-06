import 'package:flutter/material.dart';
import 'dart:async'; // Debouncer
import 'package:http/http.dart' as http; // Fetch api
import 'dart:convert';
import 'auth.dart';
import 'detailedView.dart'; // Accedir a la vista detallada

// Pantalla list animals
// StatefulWidget: perque pugui anar canviant la vista (lllista)
class ListAnimals extends StatefulWidget {
  const ListAnimals({super.key}); // Constructor per cridar al StateFulWidget

  @override
  State<ListAnimals> createState() => ListAnimalsState(); // Creem instancia de la classe
}

// Implementacio del state per ListAnimals
class ListAnimalsState extends State<ListAnimals> {
  List<dynamic> animalData = []; // List dinamica info api animals
  //String errorMessage = "";
  // Final: variables que no es poden modificar
  final debouncer = Debouncer(milliseconds: 400); // Per no fer la carga del searchValue al instant

  // Obtenir informacio de la api
  Future<void> _fetchAnimalsData(String name) async {
    const String apiKey = 'lDB4laXCGfgMlvOQauOfpA==nNBrvyTJXNAx0Jch';

    // Actualitzem informacio
    if (name.isEmpty) {
      setState(() {
        animalData = [];
      });
      return;
    }

    // Obtenir informacio de la api
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/animals?name=$name'),
      headers: {'X-Api-Key': apiKey},
    );

    // Guardar la informacio correcte
    if (response.statusCode == 200) {
      setState(() {
        animalData = json.decode(response.body);
        print(animalData);
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

  //Aqui poso el botó de SignOut amb el seu mètode. El coloquem al appBar
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
    return const Text('Firebase Auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
        title: const Text('List Animals'),
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
                      const Icon(Icons.search, color: Colors.white),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter search name',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                            border: InputBorder.none,
                          ),
                          // Petició a la API segons la busqueda
                          onChanged: (value) {
                            debouncer.run(() {
                              if (value == '') {
                                setState(() {
                                  animalData = [];
                                });
                              } else {
                                _fetchAnimalsData(value);
                              }
                            });
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
                      'WELCOME to AnimalSpotter, \n search your spotted animal!',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20), // Espai entre text i imatge
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
                physics: const NeverScrollableScrollPhysics(),
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
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        // Navegacio a la detailedView de l'element pulsat de la llista
                        onTap: () {
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

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
