import '../../../core/services/auth_service.dart';
import '../domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service = AuthService();

  @override
  Future<Map<String, dynamic>> login(String email, String password) {
    return service.login(email, password);
  }

  @override
  Future<Map<String, dynamic>> register(String email, String password) {
    return service.register(email, password);
  }

  @override
  Future<void> logout() {
    return service.logout();
  }
}