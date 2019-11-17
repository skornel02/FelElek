class CSVStudent {
  String name;
  int gradesAmount;
  String groupName;

  CSVStudent.fromRow(List<dynamic> row){
    name = row[0];
    gradesAmount = row[1];
    groupName = row[2];
  }

}