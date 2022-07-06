import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_architecture/core/error/failures.dart';

/// Abstract class to create and handle a new usecase in the application.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Class to handle the usecases without parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
