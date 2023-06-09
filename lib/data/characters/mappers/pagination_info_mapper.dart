import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/characters/dtos/pagination_info_dto.dart';
import 'package:rick_and_morty/domain/mappers/data_mapper.dart';
import 'package:rick_and_morty/domain/characters/model/pagination_info.f.dart';

const _pageQueryParam = 'page';

@injectable
class PaginationInfoMapper
    extends DataMapper<PaginationInfoDTO, PaginationInfo> {
  @override
  PaginationInfo call(PaginationInfoDTO dto) {
    final isPrev = dto.prev != null;
    final isNext = dto.next != null;

    int currentPage;

    if (isNext) {
      currentPage = int.parse(Uri.dataFromString(dto.next!)
              .queryParameters[_pageQueryParam]
              .toString()) -
          1;
    } else if (isPrev) {
      currentPage = int.parse(Uri.dataFromString(dto.prev!)
              .queryParameters[_pageQueryParam]
              .toString()) +
          1;
    } else {
      currentPage = 1;
    }

    return PaginationInfo(
      currentPage: currentPage,
      totalPages: dto.pages,
      hasPrevious: isPrev,
      hasNext: isNext,
    );
  }
}
