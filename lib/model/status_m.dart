class StatusModel {
  int id;
  String status;

  StatusModel(
      {required this.id,
      required this.status});

  StatusModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status
      };
}
