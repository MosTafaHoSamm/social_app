abstract class RegisterState{}
class RegisterInitialState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterErrorState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}


class CreateUserSuccessState extends RegisterState{
  final String uId;

  CreateUserSuccessState(this.uId);
}
class CreateUserErrorState extends RegisterState{}
class CreateUserLoadingState extends RegisterState{}