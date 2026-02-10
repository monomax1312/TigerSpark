import '../entities/recommendation.dart';
import '../repositories/recommendation_repository.dart';

class GetRecommendations {
  const GetRecommendations(this._repository);
  final RecommendationRepository _repository;

  Future<List<Recommendation>> call() => _repository.getRecommendations();
}
