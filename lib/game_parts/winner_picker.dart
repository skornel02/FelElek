import 'package:dusza2019/pojos/pojo_student.dart';
import 'dart:math';

PojoStudent pickWinner(List<PojoStudent> students) {
  if(students.length == 1)
    return students[0];

  int gradeAmountMin = students.map((PojoStudent student) {
    return student.grades.length;
  }).reduce(min);
  List<double> diffToMin = students.map((PojoStudent student) {
    return gradeAmountMin / student.grades.length;
  }).toList();
  double sumOfDifferences = 1 / diffToMin.reduce((a, b) => a + b);
  List<double> chance = diffToMin.map((double diffToMin) {
    return diffToMin * sumOfDifferences;
  }).toList();
  double random = Random.secure().nextDouble();
  print(random);

  int studentIndex = 0;
  double sum = 0;
  while(studentIndex < students.length){
    double nextSum = sum + chance[studentIndex];
    print(sum.toStringAsFixed(2)  + " < " + random.toStringAsFixed(2) + " < " + nextSum.toStringAsFixed(2));
    if(sum < random && random < nextSum)
      break;

    sum = nextSum;
    studentIndex++;
  }

  print("Winner: " + students[studentIndex].name + " /w " + (chance[studentIndex] * 100).toStringAsFixed(2) + "%");
  return students[studentIndex];
}