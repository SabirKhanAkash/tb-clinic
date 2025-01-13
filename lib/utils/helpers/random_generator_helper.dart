import 'dart:math';

class RandomGeneratorHelper {
  String generateRandomTime() {
    final random = Random();
    final hour = random.nextInt(12) + 1;
    final minute = random.nextInt(60);
    final period = random.nextBool() ? "AM" : "PM";
    final formattedMinute = minute.toString().padLeft(2, '0');

    return "$hour:$formattedMinute $period";
  }

  String generateRandomName() {
    final firstNames = [
      'John',
      'Jane',
      'Alex',
      'Emily',
      'Michael',
      'Sarah',
      'David',
      'Sophia',
      'Chris',
      'Emma'
    ];
    final lastNames = [
      'Smith',
      'Johnson',
      'Brown',
      'Williams',
      'Jones',
      'Garcia',
      'Miller',
      'Davis',
      'Wilson',
      'Taylor'
    ];
    final random = Random();

    final firstName = firstNames[random.nextInt(firstNames.length)];
    final lastName = lastNames[random.nextInt(lastNames.length)];

    return '$firstName $lastName';
  }

  String generateRandomDisease() {
    final diseases = [
      'Influenza',
      'Diabetes',
      'Hypertension',
      'Asthma',
      'Migraine',
      'Arthritis',
      'COVID-19',
      'Bronchitis',
      'Tuberculosis',
      'Malaria',
      'Hepatitis',
      'Anemia',
      'Chickenpox',
      'Pneumonia',
      'Dengue',
      'Epilepsy',
      'Glaucoma',
      'Parkinson\'s Disease',
      'Alzheimer\'s Disease',
      'Cancer'
    ];
    final random = Random();

    return diseases[random.nextInt(diseases.length)];
  }

  String generateRandomRecoveryStatus() {
    final status = ['Active', 'Recovered', 'Follow up'];
    final random = Random();

    return status[random.nextInt(status.length)];
  }
}
