class GroupApiFailure implements Exception {
  const GroupApiFailure(this.code);
  final String code;
}
