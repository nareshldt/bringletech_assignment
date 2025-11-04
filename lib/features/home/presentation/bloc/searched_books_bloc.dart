import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'searched_books_event.dart';
part 'searched_books_state.dart';

class SearchedBooksBloc extends Bloc<SearchedBooksEvent, SearchedBooksState> {
  SearchedBooksBloc() : super(SearchedBooksInitial()) {
    on<SearchedBooksEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
