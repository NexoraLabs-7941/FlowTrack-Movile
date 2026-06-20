import '../data/dashboard_model.dart';

abstract class DashboardRepository {
  Future<DashboardModel> getDashboard();
}