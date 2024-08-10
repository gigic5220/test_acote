import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@freezed
class Repository with _$Repository {
  const factory Repository({
    required String name,
    required String description,
    @JsonKey(name: 'stargazers_count') required int stargazersCount,
    required String language,
  }) = _Repository;

  factory Repository.fromJson(Map<String, Object?> json) => _$RepositoryFromJson(json);
}

