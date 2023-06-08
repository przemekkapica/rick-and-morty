abstract class DataMapper<TInput, TOut> {
  TOut call(TInput dto);
}
