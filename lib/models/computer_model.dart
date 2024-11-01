class Computer {
  final int? id;
  final String processor;
  final String hardDrive;
  final String ram;

  Computer({
    this.id,
    required this.processor,
    required this.hardDrive,
    required this.ram,
  });

  // Método para convertir la instancia en un mapa (Map<String, dynamic>)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'processor': processor,
      'hardDrive': hardDrive,
      'ram': ram,
    };
  }

  // Método para crear una instancia de Computer desde un mapa (Map<String, dynamic>)
  factory Computer.fromMap(Map<String, dynamic> map) {
    return Computer(
      id: map['id'],
      processor: map['processor'],
      hardDrive: map['hardDrive'],
      ram: map['ram'],
    );
  }

  Computer copyWith({
    int? id,
    String? processor,
    String? hardDrive,
    String? ram,
  }) {
    return Computer(
      id: id ?? this.id,
      processor: processor ?? this.processor,
      hardDrive: hardDrive ?? this.hardDrive,
      ram: ram ?? this.ram,
    );
  }
}
