class MySqlQueries {
  static String getAll(String tableName, String idName) =>
      "SELECT * FROM $tableName ORDER BY $idName DESC LIMIT 1000";

  static String getByQuery(
    String tableName, {
    required String column,
    required String query,
    required String idName,
  }) =>
      "SELECT * FROM $tableName WHERE $column LIKE '%$query%' ORDER BY $idName DESC LIMIT 1000";
}
