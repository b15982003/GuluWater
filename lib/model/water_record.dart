class WaterRecord {
  static const waterType = 'type';
  static const waterValue = 'value';
  static const waterDate = 'date';
  static const waterTime = 'time';
  static const waterTimestamp = 'timeStamp';
  static const waterNote = 'note';

  final String type;
  final int value;
  final String date;
  final String time;
  final int timeStamp;
  final String note;

  WaterRecord({
    required this.type,
    required this.value,
    required this.date,
    required this.time,
    required this.timeStamp,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      waterType: type,
      waterValue: value,
      waterDate: date,
      waterTime: time,
      waterTimestamp: timeStamp,
      waterNote: note,
    };
  }
}
