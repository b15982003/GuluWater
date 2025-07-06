
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/core/provider/water_data_provider.dart';
import 'package:gulu_water/feature/home/provider/today_water_record_provider.dart';
import 'package:gulu_water/feature/home/provider/week_water_record_provider.dart';
import 'package:gulu_water/model/water_record.dart';

import '../../core/theme/gu_direct.dart';

class AddRecordPage extends ConsumerStatefulWidget {
  const AddRecordPage({super.key});

  @override
  ConsumerState<AddRecordPage> createState() => _AddRecordState();
}

class _AddRecordState extends ConsumerState<AddRecordPage> {
  late WaterDataProvider _waterDataProvider;
  late ToDayWaterDataProvider _toDayWaterDataProvider;
  late WeekWaterDataProvider _weekWaterDataProvider;
  var dateTimeNow = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  var valueInt = 100;

  @override
  void initState() {
    super.initState();
    _dateController.text = dateTimeNow.toString().split(" ")[0];
    _timeController.text = '${dateTimeNow.hour}:${dateTimeNow.minute}';
    _valueController.text = '100';
    _remarkController.text = '';
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _valueController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _waterDataProvider = ref.watch(waterDataProvider.notifier);
    _toDayWaterDataProvider = ref.watch(toDayWaterRecordProvider.notifier);
    _weekWaterDataProvider = ref.watch(weekWaterRecordProvider.notifier);

    var appBar = AppBar(title: const Text('新增數據'));

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: GuDirect.space20,
          horizontal: GuDirect.space20,
        ),
        child: Column(
          spacing: GuDirect.space20,
          children: [
            Container(child: _dateWidget(context)),
            Container(child: _timeWidget(context)),
            Container(child: _valueWidget(context)),
            Container(child: _remarkWidget(context)),
            Container(child: _btnSaveWidget(context)),
            SizedBox(height: GuDirect.space16),
          ],
        ),
      ),
    );
  }

  Widget _dateWidget(BuildContext context) {
    return TextField(
      controller: _dateController,
      style: const TextStyle(fontSize: GuDirect.fontSize20),
      decoration: InputDecoration(
        filled: true,
        labelText: '日期',
        labelStyle: TextStyle(fontSize: GuDirect.fontSize20),
        prefixIcon: Icon(Icons.calendar_today),
        fillColor: GuDirect.backgroundWhite,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: GuDirect.borderGray),
          borderRadius: BorderRadius.circular(GuDirect.fontSize20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: GuDirect.borderGray),
          borderRadius: BorderRadius.circular(GuDirect.fontSize20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: GuDirect.borderGray),
          borderRadius: BorderRadius.circular(GuDirect.fontSize20),
        ),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }

  Widget _timeWidget(BuildContext context) {
    return TextField(
      controller: _timeController,
      style: const TextStyle(fontSize: GuDirect.fontSize20),
      decoration: InputDecoration(
        filled: true,
        labelText: '時間',
        labelStyle: TextStyle(fontSize: GuDirect.fontSize20),
        prefixIcon: Icon(Icons.access_time),
        fillColor: GuDirect.backgroundWhite,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: GuDirect.borderGray),
          borderRadius: BorderRadius.circular(GuDirect.fontSize20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: GuDirect.borderGray),
          borderRadius: BorderRadius.circular(GuDirect.fontSize20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: GuDirect.borderGray),
          borderRadius: BorderRadius.circular(GuDirect.fontSize20),
        ),
      ),
      readOnly: true,
      onTap: () => _selectTime(context),
    );
  }

  Widget _valueWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _valueController,
            style: const TextStyle(fontSize: GuDirect.fontSize20),
            onChanged: (value) {
              final input = int.tryParse(value);

              if (input == null) {
                _valueController.text = '100';
                valueInt = 100;
              } else if (input < 1 || input > 10000) {
                _valueController.text = '10';
                valueInt = 10;
              } else {
                valueInt = input;
              }
            },
            decoration: InputDecoration(
              filled: true,
              labelText: '飲水量',
              labelStyle: TextStyle(fontSize: GuDirect.fontSize20),
              fillColor: GuDirect.backgroundWhite,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: GuDirect.borderGray),
                borderRadius: BorderRadius.circular(GuDirect.fontSize20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: GuDirect.borderGray),
                borderRadius: BorderRadius.circular(GuDirect.fontSize20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: GuDirect.borderGray),
                borderRadius: BorderRadius.circular(GuDirect.fontSize20),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: GuDirect.space8),
          child: const Text(
            'ml',
            style: TextStyle(
              fontSize: GuDirect.fontSize20,
              color: GuDirect.textGray,
            ),
          ),
        ),
      ],
    );
  }

  Widget _remarkWidget(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextField(
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        controller: _remarkController,
        style: const TextStyle(fontSize: GuDirect.fontSize20),
        decoration: InputDecoration(
          filled: true,
          hintText: '請輸入備註',
          labelStyle: TextStyle(fontSize: GuDirect.fontSize20),
          fillColor: GuDirect.backgroundWhite,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: GuDirect.borderGray),
            borderRadius: BorderRadius.circular(GuDirect.fontSize20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: GuDirect.borderGray),
            borderRadius: BorderRadius.circular(GuDirect.fontSize20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: GuDirect.borderGray),
            borderRadius: BorderRadius.circular(GuDirect.fontSize20),
          ),
        ),
      ),
    );
  }

  Widget _btnSaveWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: GuDirect.backgroundWaterBlue,
          padding: const EdgeInsets.symmetric(vertical: GuDirect.space8),
        ),
        onPressed: () {
          _saveWaterRecord();
        },
        child: const Text(
          '保存',
          style: TextStyle(
            fontSize: GuDirect.fontSize20,
            color: GuDirect.backgroundWhite,
          ),
        ),
      ),
    );
  }

  void _saveWaterRecord() {
    final waterRecord = WaterRecord(
      type: "",
      value: valueInt,
      date: _dateController.text,
      timeStamp: _timeController.text,
      note: _remarkController.text,
    );
    _waterDataProvider.addWaterRecord(waterRecord);
    _toDayWaterDataProvider.updateWaterRecord();
    _weekWaterDataProvider.updateWeekWaterRecord();
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final oldValue = _dateController.text;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTimeNow,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _dateController.text = '${picked.year}-${picked.month}-${picked.day}';
    } else {
      _dateController.text = oldValue;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final oldValue = _timeController.text;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay(
        hour: dateTimeNow.hour,
        minute: dateTimeNow.minute,
      ),
    );
    if (picked != null) {
      _timeController.text = '${picked.hour}:${picked.minute}';
    } else {
      _timeController.text = oldValue;
    }
  }
}
