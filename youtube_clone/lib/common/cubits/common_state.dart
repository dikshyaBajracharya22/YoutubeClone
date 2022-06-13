abstract class CommonState{}

class CommonInitialState extends CommonState{}

class CommonLoadingState extends CommonState{}

class CommonDummyLoadingState extends CommonState{}

class CommonErrorState extends CommonState{
final String message;

CommonErrorState({required this.message});
}

class CommonSuccessState<T> extends CommonState{
  T data;
  CommonSuccessState({required this.data});
}

class CommonDataFetchedState<T> extends CommonState{
  List<T> items;
  CommonDataFetchedState({required this.items});
}
