import 'package:flutter/material.dart';

class CustomDateAndTime extends StatefulWidget {
  final Widget child;
  final bool enableDateOnly;
  final bool enableTime;
  final Function(DateTime?, String?) onSelected;

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CustomDateAndTime({
    super.key,
    required this.child,
    this.enableDateOnly = true,
    this.enableTime = false,
    required this.onSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  _CustomDateAndTimeState createState() => _CustomDateAndTimeState();
}

class _CustomDateAndTimeState extends State<CustomDateAndTime> {
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _selectedDateTime = widget.initialDate;
    }
  }

  // Helper to ensure the starting date is within the allowed range
  DateTime _getValidInitialDate() {
    final DateTime now = DateTime.now();
    final DateTime first = widget.firstDate ?? DateTime(1940);
    final DateTime last = widget.lastDate ?? DateTime(2100);

    // 1. Priority: Current selection
    DateTime base = _selectedDateTime ?? widget.initialDate ?? now;

    // 2. Safety Check: If base is before firstDate, use firstDate
    if (base.isBefore(first)) return first;

    // 3. Safety Check: If base is after lastDate, use lastDate
    if (base.isAfter(last)) return last;

    return base;
  }

  Future<void> _openPicker() async {
    if (!widget.enableDateOnly && widget.enableTime) {
      await _selectTime(_getValidInitialDate());
      return;
    }
    await _selectDate();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _getValidInitialDate(),
      firstDate: widget.firstDate ?? DateTime(1940),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (pickedDate != null) {
      if (widget.enableTime) {
        await _selectTime(pickedDate);
      } else {
        _setSelectedDateTime(pickedDate);
      }
    }
  }

  Future<void> _selectTime(DateTime baseDate) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? baseDate),
    );

    if (pickedTime != null) {
      final DateTime finalDateTime = DateTime(
        baseDate.year,
        baseDate.month,
        baseDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      _setSelectedDateTime(finalDateTime);
    } else {
      _setSelectedDateTime(baseDate);
    }
  }

  void _setSelectedDateTime(DateTime dateTime) {
    setState(() {
      _selectedDateTime = dateTime;
    });
    widget.onSelected(dateTime, _formatDateTime(_selectedDateTime!));
  }

  String _formatDateTime(DateTime dateTime) {
    if (widget.enableDateOnly && !widget.enableTime) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (!widget.enableDateOnly && widget.enableTime) {
      return '${_formatTime(dateTime.hour)}:${_formatTime(dateTime.minute)}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${_formatTime(dateTime.hour)}:${_formatTime(dateTime.minute)}';
    }
  }

  String _formatTime(int time) => time.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return _DatePickerWrapper(onTap: _openPicker, child: widget.child);
  }
}

class _DatePickerWrapper extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _DatePickerWrapper({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IgnorePointer(child: child),
    );
  }
}
