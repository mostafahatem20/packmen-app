import 'package:packmen_app/core/app_export.dart';

class TaskModel {
  int? id;
  String? type;
  String? title;
  DateTime? time;
  bool? done;
  List<Box>? boxes;
  List<Parcel>? parcels;
  String? locationName;
  LatLng? geoLocation;

  TaskModel(
      {this.id,
      this.type,
      this.title,
      this.time,
      this.done,
      this.boxes,
      this.parcels,
      this.geoLocation,
      this.locationName});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> boxList = json['boxes'] as List;
    List<Box> _boxes = boxList.map((e) => Box.fromJson(e)).toList();
    List<dynamic> parcelList = json['parcels'] as List;
    List<Parcel> _parcels = parcelList.map((e) => Parcel.fromJson(e)).toList();
    return TaskModel(
        id: json['id'],
        type: json['type'],
        title: json['title'],
        time: DateTime.parse(json['time']),
        done: json['done'],
        locationName: json['location']['name'],
        geoLocation: LatLng(json['location']['geoLocation']['lat'],
            json['location']['geoLocation']['lng']),
        boxes: _boxes,
        parcels: _parcels);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type, 'title': title, 'time': time, 'done': done};
  }
}

class Box {
  int? id;
  bool? done;
  String? action;

  Box({
    this.id,
    this.done,
    this.action,
  });

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['id'] as int,
      done: json['done'] as bool,
      action: json['action'] as String,
    );
  }
}

class Parcel {
  int? id;
  bool? done;
  String? fromBox;
  String? toBox;
  String? code;

  Parcel({this.id, this.done, this.fromBox, this.toBox, this.code});

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      id: json['id'] as int,
      done: json['done'] as bool,
      fromBox: "Box #${json['fromBox']['id']}",
      toBox: "Box #${json['toBox']['id']}",
      code: json['parcel']['code'] as String,
    );
  }
}
