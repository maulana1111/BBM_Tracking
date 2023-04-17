import 'package:flutter/material.dart';

class BensinModel {
  int id;
  String value;
  String text;
  String perusahaan;
  double harga;

  BensinModel({
    required this.id,
    required this.value,
    required this.text,
    required this.perusahaan,
    required this.harga,
  });

  BensinModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'],
        text = json['text'],
        perusahaan = json['perusahaan'],
        harga = json['harga'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'text': text,
        'perusahaan': perusahaan,
        'harga': harga
      };
}
