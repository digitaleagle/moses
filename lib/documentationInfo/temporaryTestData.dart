//The data in this file is hardcoded.
//This is for testing purposes only!

//Global list of programs:
List<Program> testPrograms = [
  Program('Seekers', 'Youth ministry for grades 7-12.'),
  Program('Mighty Marks', 'Children\'s ministry for ages 3-12.'),
  Program('Young at Heart', 'Ministry for those 55 and older.'),
  Program('Woven Marriage', 'Ministry for young, married couples in their 20s, 30s, or 40s.'),
  Program('Musical Performance', 'choir, orchestra, soloists, and other musical groups.'),
  Program('Administration', 'Group of Pastors, Deacons, and Ministry Administrators.'),
];

//Temporary Program class:
class Program {
  String title;
  String description;

  Program(this.title, this.description);
}