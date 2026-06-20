import '../../../../core/services/dashboard_service.dart';
import '../domain/dashboard_repository.dart';
import 'dashboard_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final service = DashboardService();

  @override
  Future<DashboardModel> getDashboard() async {
    final json = await service.getDashboard();
    return DashboardModel.fromJson(json);
  }
}