class TncEntity {
  final String value;
  final int id;
  final String createdAt;
  final String updatedAt;

  bool get isEmpty => value.isEmpty;

  const TncEntity({
    required this.value,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TncEntity.fromMap(Map<String, dynamic> map) {
    return TncEntity(
      value: map['value'] as String,
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  const TncEntity.empty()
      : value = '',
        id = 0,
        createdAt = '',
        updatedAt = '';

  factory TncEntity.newTnc() {
    final id = DateTime.now().millisecondsSinceEpoch;
    return TncEntity(
      value: '',
      id: id,
      createdAt: '',
      updatedAt: '',
    );
  }

  TncEntity copyWith({
    String? value,
    int? id,
    String? createdAt,
    String? updatedAt,
  }) {
    return TncEntity(
      value: value ?? this.value,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
