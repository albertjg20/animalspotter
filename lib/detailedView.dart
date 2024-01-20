import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

class detailedView extends StatelessWidget {
  final Map<String, dynamic> animal; // Animal seleccionat

  const detailedView({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal['name'] ?? 'Name not available'),// Titol pantalla
      ),
      body: SingleChildScrollView( // Controla el resize dels elements child
        // Elements en ordre columna
        child: Column(
          // Aliniar el nom cientific al centre
          crossAxisAlignment: CrossAxisAlignment.center,
          // Mostrar nom cientific animal
          children: [
            Text(
              "\"${animal['taxonomy']['scientific_name'] ??
                  'Name not available'}\"",
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20.0), // Espai entre nom cientific i filera d'informacio
            // Mostrar en filera dos cuadrats d'informacio (taxonomy i characteristics)
            Row(
              // Aliniar amb distacies iguals
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // Mostrar informacio en cuadrats grisos
              children: [
                grayBox('Taxonomy', [
                  'Class: ${animal['taxonomy']['class'] ??
                      'class not available'}',
                  'Order: ${animal['taxonomy']['order'] ??
                      'order not available'}',
                  'Family: ${animal['taxonomy']['family'] ??
                      'family not available'}',
                ]),
                grayBox('Characteristics', [
                  'Young name: ${animal['characteristics']['name_of_young'] ??
                      'name not available'}',
                  'Population: ${animal['characteristics']['estimated_population_size'] ??
                      'Population not available'}',
                  'Gestation period: ${animal['characteristics']['gestation_period'] ??
                      'gestation not available'}',
                  'Lifespan: ${animal['characteristics']['lifespan'] ??
                      'lifespan not available'}',
                ]),
              ],
            ),
            const SizedBox(height: 20.0), // Espai entre fileres
            // Mostrar en filera dos cuadrats d'informacio (physiscal characteristics i distinctive feature)
            Row(
              // Aliniar amb distacies iguals
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // Mostrar informacio en cuadrats grisos
              children: [
                grayBox('Physical Characteristics', [
                  'Weight: ${animal['characteristics']['weight'] ??
                      'weight not available'}',
                  'Length: ${animal['characteristics']['length'] ??
                      'length not available'}',
                ]),
                grayBox('Most distinctive feature', [
                  '${animal['characteristics']['most_distinctive_feature'] ??
                      'not available'}',
                ]),
              ],
            ),
            const SizedBox(height: 24.0),// Espai entre cuadrats d'informacio y slogan
            // Rectangle slogan
            Container(
              width: 340.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.blue[900], // Color de ejemplo
                borderRadius: BorderRadius.circular(20.0),
              ),
              // Text slogan
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8.0),
                  const Text(
                    'Slogan:  ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '${animal['characteristics']['slogan'] ??
                        'not available'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24.0), // Espai entre slogan i boto per afegir foto
            GestureDetector(
              onTap: () {
              },
              // Contenidor del boto add photo
              child: Container(
                width: 340.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.blue[100], // Color de ejemplo
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(12.0), // Marges
                // Text i icona "add photo"
                child: const Row(
                  // Aliniar al centre del contenidor
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Mostrar text i icona
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Add photo',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24.0), // Espai entre add photo i add favorites
            // Boto per afegir l'animal a favorits
            Align(
              // Aliniar el contingut al centre
              alignment: Alignment.center,
              // Afegir a l'array de "favorites"
              child: ElevatedButton.icon(
                onPressed: () {
                  // Acción al agregar a favoritos
                },
                // Mostrar Icona i text
                icon: const Icon(
                  Icons.star,
                  color: Colors.black, // Cambiar el color del icono a negro
                  size: 36.0, // Cambiar el tamaño del icono
                ),
                label: const Text(
                  'Add to Favorites',
                  style: TextStyle(color: Colors.black),
                ),
                // Modificar contenidor boto, afegir color i costats rodons
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[100], // Color amarillo claro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0), // Ajustar el radio del borde
                  ),
                  minimumSize: const Size(200.0, 60.0), // Ajustar el tamaño del botón
                ),
              ),
            ),
            const SizedBox(height: 24.0),// Marge final pagina
          ],
        ),
      ),
    );
  }

  // Widget grayBox, caixes visuals d'informació
  Widget grayBox(String text, List<String> characteristics) {
    // Contenidor amb el format i el text
    return Container(
      width: 180.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(12.0), // Marges
      // Format del text
      child: Column(
        // Aliniar al inici el text
        crossAxisAlignment: CrossAxisAlignment.start,
        // Mostrar titol en negreta
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0), // Espai entre titol i contingut
          // Mostrar contingut
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Mostrar cada element de characteristics
            children: characteristics
                .map((characteristic) =>
                Text(
                  characteristic,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black87,
                  ),
                ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
