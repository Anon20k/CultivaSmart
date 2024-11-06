double calculateTotalPlants(double hectares, double distanceBetweenPlants, double distanceBetweenRows) {
  final double areaInSquareMeters = hectares * 10000;
  final double plantsPerRow = areaInSquareMeters / distanceBetweenRows;
  final double totalPlants = plantsPerRow / distanceBetweenPlants;
  return totalPlants;
}