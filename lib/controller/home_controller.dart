import 'package:get/get.dart';
import '../models/alarm_model.dart';
import '../models/statistics_model.dart';
import '../helper/dummy_data.dart';

// Home Controller
class HomeController extends GetxController {
  // Observable data
  final _statistics = DummyData.dummyStatistics.obs;
  final _recentAlarms = <AlarmModel>[].obs;
  final _searchQuery = ''.obs;
  final _isLoading = false.obs;

  // Getters
  StatisticsModel get statistics => _statistics.value;
  List<AlarmModel> get recentAlarms => _recentAlarms;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;

  // Get greeting based on time
  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // Load data
  void loadData() {
    _isLoading.value = true;

    // Simulate loading
    Future.delayed(const Duration(milliseconds: 500), () {
      _recentAlarms.value = DummyData.recentAlarms;
      _isLoading.value = false;
    });
  }

  // Search alarms
  void searchAlarms(String query) {
    _searchQuery.value = query;
    if (query.isEmpty) {
      _recentAlarms.value = DummyData.recentAlarms;
    } else {
      _recentAlarms.value = DummyData.dummyAlarms
          .where((alarm) =>
              alarm.title.toLowerCase().contains(query.toLowerCase()))
          .take(5)
          .toList();
    }
  }

  // Refresh data
  Future<void> refresh() async {
    loadData();
  }

  // Toggle alarm enabled status
  void toggleAlarm(String alarmId) {
    final index = _recentAlarms.indexWhere((alarm) => alarm.id == alarmId);
    if (index != -1) {
      final alarm = _recentAlarms[index];
      _recentAlarms[index] = alarm.copyWith(enabled: !alarm.enabled);
    }
  }
}
