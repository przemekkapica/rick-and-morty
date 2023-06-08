abstract class BidirectionalDataMapper<TInput, TOut> {
  TOut fromDTO(TInput dto);

  TInput toDTO(TOut data);
}
