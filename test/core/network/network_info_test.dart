import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:clean_architecture/core/network/network_info.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group("isConnected", () {
    test('Should forward the call to DataConnectionChecker.hasConnection', () async {
      // arrange
      when(() => mockDataConnectionChecker.hasConnection).thenAnswer((_) async => true);
      // act
      final result = await networkInfo.isConnected;
      // assert
      verify(() => mockDataConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
