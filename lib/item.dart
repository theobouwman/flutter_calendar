
class Item {
  final String title;
  final String description;
  final LatLng latLng;
  final DateTime startDate;
  final DateTime endDate;
  final Attending attending;

  Item(this.title, this.description, this.latLng, this.startDate, this.endDate, this.attending);
}

class LatLng {
  final String alias;
  final double lat;
  final double lng;

  LatLng(this.alias, this.lat, this.lng);
}

enum Attending {
  going,
  interested,
  cannotGo
}