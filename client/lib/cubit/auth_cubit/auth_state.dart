part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class Verified extends AuthState{}

class NotVerified extends AuthCubit{}
