class MySqlQueries {
  static String getAll(String tableName, String idName) =>
      "SELECT * FROM $tableName ORDER BY $idName DESC LIMIT 1000";

  static String getByQuery(
    String tableName, {
    required String column,
    required int productId,
    required String idName,
  }) =>
      "SELECT * FROM $tableName WHERE $column LIKE '$productId' ORDER BY $idName DESC LIMIT 1000";

  static String getByDate(
    String tableName, {
    required String column,
    required int fstTimestamp,
    required int lastTimestamp,
    required String idName,
  }) =>
      // ''' SELECT * FROM $tableName WHERE $column BETWEEN '$fstTimestamp' AND '$lastTimestamp' ''';
      "SELECT * FROM $tableName WHERE $column BETWEEN '$fstTimestamp' AND '$lastTimestamp' ORDER BY $idName DESC LIMIT 1000";

  static String getByDateWithQuery(
    String tableName, {
    required String column,
    required int fstTimestamp,
    required int lastTimestamp,
    required int productId,
    required String idName,
  }) =>
      "SELECT * FROM $tableName WHERE $column BETWEEN '%$fstTimestamp%' AND '%$lastTimestamp%' LIKE '%$productId%' ORDER BY $idName DESC LIMIT 1000";
}
