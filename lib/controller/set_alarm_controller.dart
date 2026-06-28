import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Set Alarm Controller
class SetAlarmController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // Observable data
  final _currentTabIndex = 0.obs;
  final _alarmTitle = ''.obs;
  final _selectedTime = TimeOfDay.now().obs;
  final _repeatEnabled = false.obs;
  final _selectedDays = <int>[].obs;
  final _selectedSound = 'Default'.obs;
  final _locationName = ''.obs;
  final _radius = 500.0.obs;

  // Text controllers
  final titleController = TextEditingController();
  final locationController = TextEditingController();

  // Getters
  int get currentTabIndex => _currentTabIndex.value;
  String get alarmTitle => _alarmTitle.value;
  TimeOfDay get selectedTime => _selectedTime.value;
  bool get repeatEnabled => _repeatEnabled.value;
  List<int> get selectedDays => _selectedDays;
  String get selectedSound => _selectedSound.value;
  String get locationName => _locationName.value;
  double get radius => _radius.value;

  // Sound options
  final List<String> soundOptions = [
    'Default',
    'Bell',
    'Chime',
    'Ding',
    'Beep',
    'Alert',
    'Zen',
    'Calm',
    'Drop',
  ];

  // Day labels
  final List<String> dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      _currentTabIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    titleController.dispose();
    locationController.dispose();
    super.onClose();
  }

  // Update alarm title
  void updateTitle(String title) {
    _alarmTitle.value = title;
  }

  // Select time
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime.value,
    );
    if (picked != null) {
      _selectedTime.value = picked;
    }
  }

  // Toggle repeat
  void toggleRepeat(bool value) {
    _repeatEnabled.value = value;
    if (!value) {
      _selectedDays.clear();
    }
  }

  // Toggle day selection
  void toggleDay(int day) {
    if (_selectedDays.contains(day)) {
      _selectedDays.remove(day);
    } else {
      _selectedDays.add(day);
    }
  }

  // Select sound
  void selectSound(String sound) {
    _selectedSound.value = sound;
  }

  // Update location
  void updateLocation(String location) {
    _locationName.value = location;
    locationController.text = location;
  }

  // Update radius
  void updateRadius(double value) {
    _radius.value = value;
  }

  // Select location (placeholder - would open map in real implementation)
  void selectLocation() {
    // Placeholder - would open location picker
    updateLocation('Selected Location');
    Get.snackbar(
      'Location',
      'Location picker would open here',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Save time alarm
  void saveTimeAlarm() {
    if (titleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter alarm title',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Success',
      'Time alarm created successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );

    // Reset form
    resetForm();
  }

  // Save location alarm
  void saveLocationAlarm() {
    if (titleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter alarm title',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (_locationName.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a location',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Success',
      'Location alarm created successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );

    // Reset form
    resetForm();
  }

  // Reset form
  void resetForm() {
    titleController.clear();
    locationController.clear();
    _alarmTitle.value = '';
    _selectedTime.value = TimeOfDay.now();
    _repeatEnabled.value = false;
    _selectedDays.clear();
    _selectedSound.value = 'Default';
    _locationName.value = '';
    _radius.value = 500.0;
  }
}
