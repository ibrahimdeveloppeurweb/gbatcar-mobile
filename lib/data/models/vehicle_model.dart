class VehicleModel {
  final String id;
  final String model;
  final String plateNumber;
  final String vin;
  final double mileage;
  final DateTime? lastMaintenance;
  final DateTime? nextMaintenance;
  final String status; // 'active', 'maintenance', 'out_of_service'

  VehicleModel({
    required this.id,
    required this.model,
    required this.plateNumber,
    required this.vin,
    this.mileage = 0.0,
    this.lastMaintenance,
    this.nextMaintenance,
    this.status = 'active',
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? '',
      model: json['model'] ?? '',
      plateNumber: json['plate_number'] ?? '',
      vin: json['vin'] ?? '',
      mileage: (json['mileage'] ?? 0.0).toDouble(),
      lastMaintenance: json['last_maintenance'] != null
          ? DateTime.parse(json['last_maintenance'])
          : null,
      nextMaintenance: json['next_maintenance'] != null
          ? DateTime.parse(json['next_maintenance'])
          : null,
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'plate_number': plateNumber,
      'vin': vin,
      'mileage': mileage,
      'last_maintenance': lastMaintenance?.toIso8601String(),
      'next_maintenance': nextMaintenance?.toIso8601String(),
      'status': status,
    };
  }

  VehicleModel copyWith({
    String? id,
    String? model,
    String? plateNumber,
    String? vin,
    double? mileage,
    DateTime? lastMaintenance,
    DateTime? nextMaintenance,
    String? status,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      model: model ?? this.model,
      plateNumber: plateNumber ?? this.plateNumber,
      vin: vin ?? this.vin,
      mileage: mileage ?? this.mileage,
      lastMaintenance: lastMaintenance ?? this.lastMaintenance,
      nextMaintenance: nextMaintenance ?? this.nextMaintenance,
      status: status ?? this.status,
    );
  }
}
