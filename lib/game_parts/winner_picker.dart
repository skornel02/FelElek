import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'dart:math';

PojoStudent pickWinner(List<PojoStudent> students) {
  if (students.length == 0) return null;
  if (students.length == 1) return students[0];

  List<double> chance = calculateChances(students);
  double random = Random.secure().nextDouble();
  print(random);

  int studentIndex = 0;
  double sum = 0;
  while (studentIndex < students.length) {
    double nextSum = sum + chance[studentIndex];
    print(sum.toStringAsFixed(2) +
        " < " +
        random.toStringAsFixed(2) +
        " < " +
        nextSum.toStringAsFixed(2));
    if (sum < random && random < nextSum) break;

    sum = nextSum;
    studentIndex++;
  }

  print("Winner: " +
      students[studentIndex].name +
      " /w " +
      (chance[studentIndex] * 100).toStringAsFixed(2) +
      "%");
  return students[studentIndex];
}

List<double> calculateChances(List<PojoStudent> students) {
  if (students.isEmpty) return [];
  double gradeAmountMin = students.map((PojoStudent student) {
    double length = student.grades.length.toDouble();
    if (length == 0) length = 0.5;
    return length;
  }).reduce(min);
  List<double> diffToMin = students.map((PojoStudent student) {
    double length = student.grades.length.toDouble();
    if (length == 0) length = 0.5;
    return gradeAmountMin / length;
  }).toList();
  double sumOfDifferences = 1 / diffToMin.reduce((a, b) => a + b);
  List<double> chance = diffToMin.map((double diffToMin) {
    return diffToMin * sumOfDifferences;
  }).toList();
  return chance;
}
