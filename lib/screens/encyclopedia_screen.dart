import 'package:flutter/material.dart';

class EncyclopediaScreen extends StatelessWidget {
  final List<Map<String, String>> varieties = [
    {'name': 'Cabernet Sauvignon', 'image': 'assets/uva4.png'},
    {'name': 'Sauvignon Blanc', 'image': 'assets/uva3.png'},
    {'name': 'Merlot', 'image': 'assets/uva2.png'},
    {'name': 'Carmenère', 'image': 'assets/uva4.png'},
    {'name': 'Chardonnay', 'image': 'assets/uva3.png'},
    {'name': 'Syrah', 'image': 'assets/uva4.png'},
    {'name': 'Pinot Noir', 'image': 'assets/uva4.png'},
    {'name': 'Pais', 'image': 'assets/uva4.png'},
    {'name': 'Malbec', 'image': 'assets/uva4.png'},
    {'name': 'Carignan', 'image': 'assets/uva4.png'},
    {'name': 'Riesling', 'image': 'assets/uva3.png'},
    {'name': 'Gewürztraminer', 'image': 'assets/uva3.png'},
    {'name': 'Semillon', 'image': 'assets/uva3.png'},
    {'name': 'Viognier', 'image': 'assets/uva3.png'},
    {'name': 'Petit Verdot', 'image': 'assets/uva4.png'},
    {'name': 'Tempranillo', 'image': 'assets/uva4.png'},
    {'name': 'Cabernet Franc', 'image': 'assets/uva4.png'},
    {'name': 'Grenache', 'image': 'assets/uva4.png'},
    {'name': 'Marsanne', 'image': 'assets/uva3.png'},
    {'name': 'Mourvèdre', 'image': 'assets/uva4.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inciclopedia de variedades de plantas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
            final aspectRatio = constraints.maxWidth < 600 ? 3 / 4 : 1 / 1;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: aspectRatio,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: varieties.length,
              itemBuilder: (context, index) {
                final variety = varieties[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            variety['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        variety['name']!,
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 600 ? 16 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}