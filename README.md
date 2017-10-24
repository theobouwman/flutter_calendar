# Calendar package for Flutter

A calendar package for [Flutter](https://flutter.io/)

## Getting Started

```dart
new Calendar(
  [
    new Item(
      "Item 1", 
      "description", 
      new LatLng(0.0, 0.0), 
      StartDateTime, 
      EndDateTime, 
      Attending.cannotGo
    )
  ],
  (Item i) => {render}
  new Center(
    child: new Text("No results"),
  ),
  title: "hello",
  dateFormat: DateFormat.English,
)
```

## Showcase
![](https://github.com/theobouwman/flutter_calendar/blob/master/showcase.png)
