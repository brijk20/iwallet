final String tName = "TNX";
final String colId = "id";
final String colName = "name";
final String colCategory = "category";
final String colAmount = "amount";

class Transactions {
  int id;
  String name;
  String category;
  num amount;

  Transactions(this.id, this.name, this.category, this.amount);

  Transactions.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colName];
    category = map[colCategory];
    amount = map[colAmount];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colId: id, //Extra
      colName: name,
      colCategory: category,
      colAmount: amount,
    };
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }
}
