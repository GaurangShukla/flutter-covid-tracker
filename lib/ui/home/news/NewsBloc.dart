
import 'package:go_away_covid19/models/RpNews.dart';
import 'package:go_away_covid19/network/Repository.dart';
import 'package:rxdart/rxdart.dart';

final bloc = NewsBloc();

class NewsBloc {
  final _repository = Repository();
  final newsFetcher = BehaviorSubject<RpNews>();

  Stream<RpNews> get newses => newsFetcher.stream;

  getNewses() async {
    RpNews newses = await _repository.getNewses();
    newsFetcher.sink.add(newses);
  }
  dispose() {
    newsFetcher.close();
  }

}