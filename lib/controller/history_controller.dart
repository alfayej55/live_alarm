import 'package:get/get.dart';
import '../models/alarm_model.dart';
import '../helper/dummy_data.dart';

// History Controller
class HistoryController extends GetxController {
  // Observable data
  final _alarms = <AlarmModel>[].obs;
  final _filteredAlarms = <AlarmModel>[].obs;
  final _searchQuery = ''.obs;
  final _selectedFilter = 'All'.obs;
  final _isLoading = false.obs;

  // Getters
  List<AlarmModel> get alarms => _filteredAlarms;
  String get searchQuery => _searchQuery.value;
  String get selectedFilter => _selectedFilter.value;
  bool get isLoading => _isLoading.value;

  // Filter options
  final List<String> filterOptions = ['All', 'Time', 'Location', 'Active', 'Completed'];

  @override
  void onInit() {
    super.onInit();
    loadAlarms();
  }

  // Load alarms
  void loadAlarms() {
    _isLoading.value = true;

    // Simulate loading
    Future.delayed(const Duration(milliseconds: 500), () {
      _alarms.value = DummyData.dummyAlarms;
      _filteredAlarms.value = _alarms;
      _isLoading.value = false;
    });
  }

  // Search alarms
  void searchAlarms(String query) {
    _searchQuery.value = query;
    _applyFilters();
  }

  // Select filter
  void selectFilter(String filter) {
    _selectedFilter.value = filter;
    _applyFilters();
  }

  // Apply filters
  void _applyFilters() {
    var filtered = _alarms.toList();

    // Apply search
    if (_searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((alarm) =>
              alarm.title.toLowerCase().contains(_searchQuery.value.toLowerCase()) ||
              alarm.typeLabel.toLowerCase().contains(_searchQuery.value.toLowerCase()))
          .toList();
    }

    // Apply filter
    switch (_selectedFilter.value) {
      case 'Time':
        filtered = filtered.where((alarm) => alarm.type == AlarmType.time).toList();
        break;
      case 'Location':
        filtered = filtered.where((alarm) => alarm.type == AlarmType.location).toList();
        break;
      case 'Active':
        filtered = filtered.where((alarm) => alarm.status == AlarmStatus.active).toList();
        break;
      case 'Completed':
        filtered = filtered.where((alarm) => alarm.status == AlarmStatus.completed).toList();
        break;
      default:
        // All - no additional filter
        break;
    }

    _filteredAlarms.value = filtered;
  }

  // Delete alarm
  void deleteAlarm(String alarmId) {
    _alarms.removeWhere((alarm) => alarm.id == alarmId);
    _applyFilters();
    Get.snackbar(
      'Deleted',
      'Alarm deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Refresh data
  Future<void> refresh() async {
    loadAlarms();
  }
}
