import 'package:card_based_ui_for_multiple_categories/course_model.dart';
import 'package:card_based_ui_for_multiple_categories/widget/course_card.dart' show CourseCard;
import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    
  final List<Course> courses = [
    Course(
      title: 'Full Stack Web Development with JavaScript (MERN)',
      imageUrl: 'assets/courses/mern.png',
      remainingSeat: '৪ সিট বাকি',
      batch: 'ব্যাচ ১৩',
      remainingDays: '৩ দিন বাকি',
    ),
    Course(
      title: 'Full Stack Web Development with Python, Django & React',
      imageUrl: 'assets/courses/python.png',
      remainingSeat: '৯৫ সিট বাকি',
      batch: 'ব্যাচ ৮',
      remainingDays: '৩১ দিন বাকি',
    ),
    Course(
      title: 'App Development with Flutter',
      imageUrl: 'assets/courses/flutter.png',
      remainingSeat: '৩ সিট বাকি',
      batch: 'ব্যাচ ১৪',
      remainingDays: '৪ দিন বাকি',
    ),
    Course(
      title: 'SQA: Manual & Automated Testing',
      imageUrl: 'assets/courses/sqa.png',
      remainingSeat: '১৫ সিট বাকি',
      batch: 'ব্যাচ ১৫',
      remainingDays: '৪ দিন বাকি',
    ),
  ];

    return Scaffold(
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: courses.length,
          itemBuilder: (context, index) => CourseCard(course: courses[index]),
        ),
      ),
    );
  }
}