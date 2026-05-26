import 'dart:io';

void main() {
	// We use a map to store student details.
	final Map<String, String> student = {};

	print('Enter student details below.');
	print('Leave blank to use "N/A".');

	// Name
	stdout.write('Name: ');
	String? nameInput = stdin.readLineSync();
	student['name'] = (nameInput == null || nameInput.trim().isEmpty)
			? 'N/A'
			: nameInput.trim();

	// Date of Birth
	stdout.write('Date of Birth (DD/MM/YYYY): ');
	String? dobInput = stdin.readLineSync();
	student['dob'] = (dobInput == null || dobInput.trim().isEmpty)
			? 'N/A'
			: dobInput.trim();

	// Department
	stdout.write('Department: ');
	String? deptInput = stdin.readLineSync();
	student['department'] = (deptInput == null || deptInput.trim().isEmpty)
			? 'N/A'
			: deptInput.trim();

	// Year
	stdout.write('Year (e.g., 1st, 2nd, 3rd): ');
	String? yearInput = stdin.readLineSync();
	student['year'] = (yearInput == null || yearInput.trim().isEmpty)
			? 'N/A'
			: yearInput.trim();

	// Email
	stdout.write('Email: ');
	String? emailInput = stdin.readLineSync();
	student['email'] = (emailInput == null || emailInput.trim().isEmpty)
			? 'N/A'
			: emailInput.trim();

	// Phone
	stdout.write('Phone: ');
	String? phoneInput = stdin.readLineSync();
	student['phone'] = (phoneInput == null || phoneInput.trim().isEmpty)
			? 'N/A'
			: phoneInput.trim();

	print('\n--- Student Details ---');
	print('Name: ${student['name']}');
	print('DOB: ${student['dob']}');
	print('Department: ${student['department']}');
	print('Year: ${student['year']}');
	print('Email: ${student['email']}');
	print('Phone: ${student['phone']}');
}
