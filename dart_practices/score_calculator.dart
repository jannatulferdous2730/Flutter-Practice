import 'dart:io';

void main() {
	// Basic variables (String, int, double)
	String studentName = '';
	int subjectCount = 3;
	double averageScore = 0.0;

	List<String> subjectNames = [];
	List<double> subjectMarks = [];

	stdout.write('Enter student name : ');
	String? nameInput = stdin.readLineSync()?.trim();
	if (nameInput == null || nameInput.isEmpty) {
		print('No name entered. Exiting.');
		return;
	}

	studentName = nameInput.trim();

	for (int i = 1; i <= subjectCount; i++) {
		stdout.write('Enter subject #$i name (or type "exit"): ');
		String? subjectInput = stdin.readLineSync();

		if (subjectInput == null || subjectInput.trim().isEmpty) {
			print('Subject name cannot be empty. Try again.');
			i--;
			continue;
		}
		if (subjectInput.trim().toLowerCase() == 'exit') {
			// Evaluate whatever is collected so far
			break;
		}

		String subjectName = subjectInput.trim();
		subjectNames.add(subjectName);

		while (true) {
			stdout.write('Enter marks for $subjectName (0-100) or type "exit": ');
			String? markInput = stdin.readLineSync();

			if (markInput == null || markInput.trim().isEmpty) {
				print('Marks cannot be empty. Try again.');
				continue;
			}
			if (markInput.trim().toLowerCase() == 'exit') {
				// Evaluate whatever is collected so far
				i = subjectCount; // exit outer loop too
				break;
			}

			double? mark = double.tryParse(markInput.trim());
			if (mark == null || mark < 0 || mark > 100) {
				print('Please enter a valid number between 0 and 100.');
				continue;
			}

			subjectMarks.add(mark);
			break;
		}
	}

	if (subjectMarks.isEmpty) {
		print('No marks entered. Exiting.');
		return;
	}

	double total = 0.0;
	for (double mark in subjectMarks) {
		total += mark;
	}
	averageScore = total / subjectMarks.length;

	String grade;
	if (averageScore >= 90) {
		grade = 'A+';
	} else if (averageScore >= 80) {
		grade = 'A';
	} else if (averageScore >= 70) {
		grade = 'B';
	} else if (averageScore >= 60) {
		grade = 'C';
	} else {
		grade = 'Fail';
	}

	print('\n--- Result ---');
	print('Student Name: $studentName');
	for (int i = 0; i < subjectMarks.length; i++) {
		String name = subjectNames.length > i ? subjectNames[i] : 'Subject ${i + 1}';
		print('Subject: $name, Marks: ${subjectMarks[i]}');
	}
	print('Average Score: ${averageScore.toStringAsFixed(2)}');
	print('Final Grade: $grade');
}
