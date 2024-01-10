import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

class detailedView extends StatelessWidget {
  final Map<String, dynamic> animal;

  detailedView({required this.animal});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal['name'] ?? 'Name not available'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSquare('Taxonomy', [
                    'Class: ${animal['taxonomy']['class'] ??
                        'class not available'}',
                    'Order: ${animal['taxonomy']['order'] ??
                        'order not available'}',
                    'Family: ${animal['taxonomy']['family'] ??
                        'family not available'}',
                  ]),
                  _buildSquare('Characteristics', [
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

              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSquare('Physical Characteristics', [
                    'Weight: ${animal['characteristics']['weight'] ??
                        'weight not available'}',
                    'Length: ${animal['characteristics']['length'] ??
                        'length not available'}',
                  ]),
                  _buildSquare('Most distinctive feature', [
                    '${animal['characteristics']['most_distinctive_feature'] ??
                        'not available'}',
                  ]),
                ],
              ),
              SizedBox(height: 24.0),
              Container(
                width: 340.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.blue[900], // Color de ejemplo
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8.0),
                    Text(
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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),
              GestureDetector(
                onTap: () {
                },
                child: Container(
                  width: 340.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.blue[100], // Color de ejemplo
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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

              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Acción al agregar a favoritos
                  },
                  icon: Icon(
                    Icons.star,
                    color: Colors.black, // Cambiar el color del icono a negro
                    size: 36.0, // Cambiar el tamaño del icono
                  ),
                  label: Text(
                    'Add to Favorites',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow[100], // Color amarillo claro
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0), // Ajustar el radio del borde
                    ),
                    minimumSize: Size(200.0, 60.0), // Ajustar el tamaño del botón
                  ),
                ),
              ),
              SizedBox(height: 24.0),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSquare(String text, List<String> characteristics) {
    return Container(
      width: 180.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: characteristics
                .map((characteristic) =>
                Text(
                  characteristic,
                  style: TextStyle(
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
