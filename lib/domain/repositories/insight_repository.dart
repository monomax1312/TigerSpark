import '../entities/insight.dart';

abstract class InsightRepository {
  Future<List<Insight>> getInsights();
  Future<void> refreshInsights();
}
