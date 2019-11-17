class CSVStudent {
  final String name;
  final int gradesAmount;
  final String groupName;

  CSVStudent(this.name, this.gradesAmount, this.groupName);

  CSVStudent.fromRow(List<dynamic> row)
      : name = row[0],
        gradesAmount = row[1],
        groupName = row[2];
}
