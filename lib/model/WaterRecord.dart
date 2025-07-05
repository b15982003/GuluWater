class WaterRecord {
  static const waterType = 'type';
  static const waterValue = 'value';
  static const waterTimestamp = 'timeStamp';
  static const waterNote = 'note';

  final String type;
  final double value;
  final String timeStamp;
  final String note;

  WaterRecord({
    required this.type,
    required this.value,
    required this.timeStamp,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      waterType: type,
      waterValue: value,
      waterTimestamp: timeStamp,
      waterNote: note,
    };
  }
}
