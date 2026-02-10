import '../entities/insight.dart';
import '../repositories/insight_repository.dart';

class GetInsights {
  const GetInsights(this._repository);
  final InsightRepository _repository;

  Future<List<Insight>> call() => _repository.getInsights();
}
