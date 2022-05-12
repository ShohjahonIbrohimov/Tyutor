import 'package:moreinfo/data/providers/private/news/get_news_provider.dart';

class NewsRepository {
  Future<Map<String, dynamic>> getNewsRP(int page) async {
    var response = await getNewsPV(page);
    List data = response.data['data']['data'];
    int toPage = response.data['data']['to'] ?? page;
    int currentPage = response.data['data']['current_page'];
    int lastPage = response.data['data']['last_page'];
    int total = response.data['data']['total'];
    // List data = [
    //   {
    //     "id": 5,
    //     "title":
    //         "IT-Park покрывает расходы на получение международных ИТ-сертификатов",
    //     "description":
    //         "Согласно Постановлению Кабинета Министров №310 от 19 мая 2021 года граждане Республики Узбекистан в возрасте от 14 до 30 лет могут получить компенсацию до 50% стоимости получения международного",
    //     "created_at": "2022-04-20 09:36:59",
    //     "updated_at": "2022-04-20 09:49:41",
    //     "image": "http://dash.wolt.uz/storage/news/news1650430181.jpg"
    //   },
    //   {
    //     "id": 5,
    //     "title":
    //         "IT-Park покрывает расходы на получение международных ИТ-сертификатов",
    //     "description":
    //         "Согласно Постановлению Кабинета Министров №310 от 19 мая 2021 года граждане Республики Узбекистан в возрасте от 14 до 30 лет могут получить компенсацию до 50% стоимости получения международного",
    //     "created_at": "2022-04-20 09:36:59",
    //     "updated_at": "2022-04-20 09:49:41",
    //     "image": "http://dash.wolt.uz/storage/news/news1650430181.jpg"
    //   },
    //   {
    //     "id": 5,
    //     "title":
    //         "IT-Park покрывает расходы на получение международных ИТ-сертификатов",
    //     "description":
    //         "Согласно Постановлению Кабинета Министров №310 от 19 мая 2021 года граждане Республики Узбекистан в возрасте от 14 до 30 лет могут получить компенсацию до 50% стоимости получения международного",
    //     "created_at": "2022-04-20 09:36:59",
    //     "updated_at": "2022-04-20 09:49:41",
    //     "image": "http://dash.wolt.uz/storage/news/news1650430181.jpg"
    //   },
    //   {
    //     "id": 5,
    //     "title":
    //         "IT-Park покрывает расходы на получение международных ИТ-сертификатов",
    //     "description":
    //         "Согласно Постановлению Кабинета Министров №310 от 19 мая 2021 года граждане Республики Узбекистан в возрасте от 14 до 30 лет могут получить компенсацию до 50% стоимости получения международного",
    //     "created_at": "2022-04-20 09:36:59",
    //     "updated_at": "2022-04-20 09:49:41",
    //     "image": "http://dash.wolt.uz/storage/news/news1650430181.jpg"
    //   },
    //   {
    //     "id": 5,
    //     "title":
    //         "IT-Park покрывает расходы на получение международных ИТ-сертификатов",
    //     "description":
    //         "Согласно Постановлению Кабинета Министров №310 от 19 мая 2021 года граждане Республики Узбекистан в возрасте от 14 до 30 лет могут получить компенсацию до 50% стоимости получения международного",
    //     "created_at": "2022-04-20 09:36:59",
    //     "updated_at": "2022-04-20 09:49:41",
    //     "image": "http://dash.wolt.uz/storage/news/news1650430181.jpg"
    //   }
    // ];

    return {
      'data': data,
      'currentPage': currentPage,
      'toPage': toPage,
      'lastPage': lastPage,
      'total': total,
    };
  }
}
