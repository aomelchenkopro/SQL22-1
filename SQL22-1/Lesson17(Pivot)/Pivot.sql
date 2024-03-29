﻿-- Создание таблицы адресов
if OBJECT_ID ('[tempdb].[dbo].#loc_01') is not null drop table #loc_01;
create table #loc_01 (
       ROW_ID    int identity(1,1), -- идент. строки
	   [ADDRESS] nvarchar(250)       -- адрес
)
;

-- Внесение значений в таблицу
insert into #loc_01 ([ADDRESS])
values (N'175226, г. Поддубное, ул. Богатырский 2-й пер, дом 21, квартира 2'),
       (N'393260, г. Шатой, ул. Гранатовый 5-й пер, дом 34, квартира 446'),
	   (N'168155, г. Романовская, ул. Кисловский Ср. пер, дом 4, подъезд 4, квартира 181'),
	   (N'188901, г. Лысьва, ул. Бронный 4-й пер, дом 30, квартира 156'),
	   (N'Украина, 652518, г. Некрасово, ул. Академика Бакева, дом 8, квартира 62'),
	   (N'368666, г. Дунаевка, ул. Александра Лукьянова, дом 74, квартира 440'),
	   (N'403973, г. Лахденпохья, ул. Бестужева 3-й пер, дом 13, квартира 73'),
	   (N'652084, г. Пряжа, ул. Васи Алексеева, дом 13, квартира 101'),
	   (N'352021, г. Междуречье, ул. Академика Волгина, дом 75, квартира 311'),
	   (N'613476, г. Тиличики, ул. Капотня 4-й кв-л, дом 65, квартира 273'),
	   (N'400064, г. Тимофеево, ул. Порядковый 1-й пер, дом 32, квартира 154'),
	   (N'156535, г. Фокино, ул. Обской пер, дом 26, квартира 79'),
	   (N'Украина, 125581, г. Октябрьское, ул. Братская, дом 70, квартира 394'),
	   (N'216227, г. Хабары, ул. Коммунстроевская, дом 23, квартира 95'),
	   (N'243422, г. Нефтекумск, ул. Гэсстроевская, дом 12, квартира 38'),
	   (N'368345, г. Белый Яр, ул. Норильская, дом 36, подъезд 6, квартира 200'),
	   (N'420136, г. Калининград, ул. Петра Алексеева 1-й пер, дом 22, квартира 39'),
	   (N'452208, г. Яренск, ул. Золоторожская наб, дом 31, квартира 194'),
	   (N'140006, г. Здвинск, ул. Орудийная, дом 46, квартира 128'),
	   (N'155331, г. Киров, ул. Головин М. пер, дом 13, квартира 500'),
	   (N'397214, г. Солтон, ул. Тучков пер, дом 11, квартира 214'),
	   (N'422142, г. Осиновка, ул. Лаврушинский пер, дом 85, квартира 139'),
	   (N'662977, г. Элиста, ул. Державинский пер, дом 40, квартира 287'),
	   (N'393460, г. Великий Новгород, ул. Домодедовская, дом 37, квартира 410'),
	   (N'453743, г. Якшур-бодья, ул. Красноводская, дом 90, квартира 147'),
	   (N'416464, г. Опочка, ул. Ягодная, дом 44, квартира 84'),
	   (N'452038, г. Зеленогорск, ул. Соревнования, дом 55, квартира 19'),
	   (N'412900, г. Шентала, ул. Путейская, дом 60, квартира 316'),
	   (N'152880, г. Заостровье, ул. Загородный 4-й проезд, дом 14, квартира 38'),
	   (N'450099, г. Мантурово, ул. Свободной России пл, дом 15, квартира 40'),
	   (N'347074, г. Бондари, ул. Дерновая, дом 28, квартира 150'),
	   (N'187504, г. Заволжье, ул. Заречье, дом 27, квартира 120'),
	   (N'658701, г. Суздаль, ул. Мурманский проезд, дом 58, квартира 140'),
	   (N'412419, г. Иглино, ул. Петропавловский туп, дом 88, квартира 368'),
	   (N'623301, г. Павлоградка, ул. Садовая, дом 13, квартира 4'),
	   (N'403621, г. Усолье-Сибирское, ул. Шелапутинский пер, дом 2, квартира 452'),
	   (N'606724, г. Новохоперск, ул. Лиговский пр-кт (Московский), дом 54, квартира 287'),
	   (N'427161, г. Кузнецк, ул. Чукотская 2-я, дом 6, квартира 69'),
	   (N'422385, г. Дульдурга, ул. Витковского, дом 90, квартира 231'),
	   (N'674055, г. Сосновоборск, ул. Кирзаводская 2-я, дом 19, квартира 39'),
	   (N'161122, г. Онгудай, ул. Автогенная, дом 58, квартира 183'),
	   (N'369389, г. Миасс, ул. Барыковский пер, дом 84, квартира 213'),
	   (N'461043, г. Сонково, ул. Чкалова  (Лианозово), дом 69, квартира 454'),
	   (N'191186, г. Радужный, ул. Волоколамский 1-й проезд, дом 86, квартира 380'),
	   (N'243156, г. Чагода, ул. Флотская, дом 35, квартира 410'),
	   (N'368758, г. Ангарск, ул. Максимова, дом 15, квартира 235'),
	   (N'678085, г. Сызрань, ул. Саперный пер, дом 7, квартира 394'),
	   (N'399832, г. Солнечный, ул. Рассказовская, дом 89, квартира 422'),
	   (N'679241, г. Грачевка, ул. Краснодарская, дом 82, квартира 237'),
	   (N'607436, г. Намцы, ул. Мирный пер, дом 34, квартира 114'),
	   (N'Украина, 174352, г. Таштып, ул. Ленина пл, дом 88, квартира 21'),
	   (N'347734, г. Омск, ул. Автогенная, дом 13, квартира 248'),
	   (N'352007, г. Славянск-на-Кубани, ул. Садовая (Центральный), дом 53, подъезд 8, квартира 354'),
	   (N'362011, г. Дальнее, ул. Северная, дом 13, квартира 46'),
	   (N'630993, г. Самара, ул. Рязанский пер, дом 32, квартира 29'),
	   (N'636782, г. Елабуга, ул. Громова, дом 56, квартира 55'),
	   (N'Украина, 693009, г. Красноярск, ул. Предпортовый 3-й проезд, дом 34, подъезд 9, квартира 253'),
	   (N'393702, г. Заозерный, ул. Боевская 1-я, дом 32, квартира 37'),
	   (N'305007, г. Вышний Волочек, ул. Батинская, дом 29, квартира 471'),
	   (N'347125, г. Сурское, ул. Овчинниковский Ср. пер, дом 71, квартира 188'),
	   (N'453024, г. Яльчики, ул. Международная, дом 69, квартира 340'),
	   (N'445550, г. Староюрьево, ул. Эриванская, дом 92, квартира 169'),
	   (N'353334, г. Энгельс, ул. Гребная, дом 13, квартира 304'),
	   (N'303031, г. Буденновск, ул. Саратовская, дом 54, квартира 169'),
	   (N'663756, г. Фатеж, ул. Харченко, дом 44, квартира 443'),
	   (N'Украина, 188523, г. Ельники, ул. Анжерская, дом 85, квартира 409'),
	   (N'309964, г. Солонешное, ул. Старорусская, дом 87, квартира 55'),
	   (N'366317, г. Агрыз, ул. Гэсстроевский 3-й пер, дом 64, квартира 115'),
	   (N'385778, г. Дзержинск, ул. Рощинская 2-я, дом 22, квартира 60'),
	   (N'646330, г. Придорожное, ул. Озерная Б., дом 29, квартира 492'),
	   (N'350014, г. Слободской, ул. Зои Космодемьянской, дом 92, квартира 484'),
	   (N'302960, г. Кардымово, ул. Сорокин пер, дом 66, квартира 209'),
	   (N'620049, г. Грозный, ул. Панаева, дом 23, квартира 24'),
	   (N'659030, г. Торопец, ул. Прокопьевская 2-я, дом 79, квартира 293'),
	   (N'396346, г. Новичиха, ул. Суворовская, дом 89, квартира 139'),
	   (N'404542, г. Унеча, ул. Журавлева, дом 13, квартира 492'),
	   (N'659325, г. Новохоперск, ул. Авиамоторная, дом 15, квартира 333'),
	   (N'429333, г. Зуевка, ул. Прядильная 3-я, дом 92, квартира 218'),
	   (N'668336, г. Западная Двина, ул. Новокузнецкий 1-й пер, дом 44, квартира 472'),
	   (N'303185, г. Лукоянов, ул. Адмиралтейский пр-кт (Центральный), дом 55, квартира 411'),
	   (N'309902, г. Кузоватово, ул. Авиационная, дом 46, квартира 331'),
	   (N'433718, г. Волгореченск, ул. Люберецкий 3-й проезд, дом 23, квартира 455'),
	   (N'624152, г. Волгодонск, ул. Горский мкр, дом 70, квартира 440'),
	   (N'690980, г. Шарыпово, ул. Калужский 9-й пер, дом 85, квартира 127'),
	   (N'423465, г. Самара, ул. Инженерная, дом 97, квартира 232'),
	   (N'102467, г. Яренск, ул. Мартина Лютера Кинга пл, дом 58, квартира 25'),
	   (N'457146, г. Сарманово, ул. Елоховская, дом 59, квартира 111'),
	   (N'620042, г. Ломоносов, ул. Олеко Дундича, дом 1, квартира 442'),
	   (N'607556, г. Пограничный, ул. Пятигорская, дом 59, квартира 101'),
	   (N'601543, г. Инжавино, ул. Ключевая  (Выборгский), дом 81, квартира 203'),
	   (N'453804, г. Урай, ул. Планерная, дом 95, квартира 483'),
	   (N'403863, г. Шушенское, ул. Иваньковское ш, дом 16, квартира 242'),
	   (N'353245, г. Учкекен, ул. Лермонтовский пр-кт, дом 16, квартира 211'),
	   (N'353688, г. Малмыж, ул. Мгинская, дом 75, квартира 378'),
	   (N'127055, г. Динская, ул. Лыкова, дом 81, квартира 453'),
	   (N'180017, г. Старый Оскол, ул. Спасоналивковский 1-й пер, дом 25, квартира 265'),
	   (N'664080, г. Неманское, ул. Броневая, дом 13, квартира 17'),
	   (N'140961, г. Сусуман, ул. Дворникова, дом 55, квартира 156'),
	   (N'187355, г. Холмогоры, ул. Автономная, дом 81, квартира 45'),
	   (N'238141, г. Каменское, ул. Добрынинский 2-й пер, дом 39, квартира 318'),
	   (N'Украина, 659353, г. Гагарин, ул. Лихоборские Бугры, дом 14, квартира 436'),
	   (N'666705, г. Хомутивка, ул. Шипиловский проезд, дом 94, квартира 482'),
	   (N'Украина, 658160, г. Маслянино, ул. Черкасский 4-й пер, дом 32, квартира 187'),
	   (N'Украина, 111399, г. Поныри, ул. Садовнический пер, дом 21, квартира 488'),
	   (N'403535, г. Пономаревка, ул. Магаданская, дом 36, квартира 150'),
	   (N'164515, г. Костомукша, ул. Голландская, дом 28, квартира 428'),
	   (N'352361, г. Никольск, ул. Лермонтовский пер, дом 80, квартира 398'),
	   (N'633634, г. Тасеево, ул. 12-я Линия линия, дом 78, квартира 163'),
	   (N'185001, г. Рыбкино, ул. Огинского, дом 82, квартира 161'),
	   (N'457661, г. Ясное, ул. Глебовский пер, дом 64, квартира 68'),
	   (N'Украина, 641713, г. Первоуральск, ул. Воскова  (Петроградский), дом 3, квартира 1'),
	   (N'Украина, 357401, г. Острогожск, ул. Партизанская, дом 43, квартира 313'),
	   (N'607760, г. Асино, ул. Крупской, дом 76, квартира 421'),
	   (N'601125, г. Выгоничи, ул. Раушская наб, дом 5, квартира 456'),
	   (N'665353, г. Жаворонково, ул. Братская, дом 98, квартира 74'),
	   (N'634033, г. Березовка, ул. Сенатская пл, дом 13, квартира 81'),
	   (N'215225, г. Родино, ул. Сельскохозяйственный 2-й проезд, дом 21, квартира 482'),
	   (N'453680, г. Филипповка, ул. Муринская дор, дом 79, квартира 332'),
	   (N'425430, г. Ульяново, ул. Баррикадная, дом 84, квартира 79'),
	   (N'Украина, 164547, г. Ленинское, ул. Айвазовского, дом 67, квартира 32'),
	   (N'Украина, 346602, г. Тальменка, ул. Батюнинская, дом 29, квартира 46'),
	   (N'445054, г. Мичуринский, ул. Жерновская 6-я, дом 96, квартира 233'),
	   (N'632495, г. Ульяново, ул. Зарайская, дом 88, квартира 499'),
	   (N'422256, г. Верхняя Пышма, ул. Кременчугская, дом 82, квартира 16'),
	   (N'144700, г. Курск, ул. Глазовский пер, дом 15, квартира 123'),
	   (N'366913, г. Псков, ул. Вересковая, дом 13, квартира 104'),
	   (N'102089, г. Советская Гавань, ул. Терлецкий проезд, дом 81, квартира 170'),
	   (N'692152, г. Майна, ул. Чкаловский пр-кт (Петроградский), дом 74, квартира 58'),
	   (N'356807, г. Спасск-Дальний, ул. Внуково Аэропорт тер, дом 93, квартира 145'),
	   (N'413371, г. Тимофеевка, ул. Демократическая, дом 78, квартира 448'),
	   (N'442435, г. Маломожайское, ул. Чоботовская 4-я аллея, дом 51, квартира 470'),
	   (N'404216, г. Поспелиха, ул. Бажова, дом 68, квартира 44'),
	   (N'606402, г. Новоегорьевское, ул. Челюскинская, дом 79, квартира 22'),
	   (N'624602, г. Усинск, ул. Грибоедова канала наб, дом 53, квартира 173'),
	   (N'163020, г. Оричи, ул. Мира, дом 76, квартира 319'),
	   (N'165673, г. Васильево, ул. Крутицкий Вал, дом 17, квартира 440'),
	   (N'462880, г. Палкино, ул. Бокситогорская, дом 99, квартира 180'),
	   (N'431316, г. Черемхово, ул. Касимовская, дом 65, квартира 256'),
	   (N'658693, г. Хомутивка, ул. Зеленхозовский 3-й пер, дом 54, подъезд 10, квартира 138'),
	   (N'397813, г. Калга, ул. Сердюкова, дом 52, квартира 464'),
	   (N'679519, г. Карпогоры, ул. Купчинская ст, дом 76, квартира 137'),
	   (N'307203, г. Клетня, ул. Вяземский сад, дом 47, квартира 494'),
	   (N'364700, г. Дубовка, ул. Лессинга аллея, дом 13, квартира 276'),
	   (N'347493, г. Нивенское, ул. Краснохолмская Нижн., дом 32, квартира 486'),
	   (N'115470, г. Ясеньское, ул. Полюстровский пр-кт (Выборгский), дом 80, квартира 230'),
	   (N'301133, г. Троицкое, ул. Ольги Берггольц, дом 70, квартира 20'),
	   (N'182284, г. Сортавала, ул. Кутузова, дом 38, квартира 425'),
	   (N'641015, г. Кореновск, ул. Какова, дом 13, квартира 290'),
	   (N'667007, г. Ирбит, ул. Ново-Рыбинская, дом 12, квартира 30'),
	   (N'400040, г. Кинель-Черкасы, ул. Поддубенский пер, дом 29, квартира 435'),
	   (N'171915, г. Чистые пруды, ул. Комсомольская, дом 42, квартира 124'),
	   (N'456610, г. Отрадная, ул. Гатчинская, дом 96, квартира 312'),
	   (N'143570, г. Чегем Первый, ул. Мукомольный проезд, дом 7, квартира 274'),
	   (N'901059, г. Усть-Ишим, ул. Василия Ботылева, дом 75, квартира 473'),
	   (N'Украина, 618513, г. Белгород, ул. Ферсмана, дом 28, квартира 283'),
	   (N'Украина, 363521, г. Курагино, ул. Соколиной Горы 9-я, дом 14, квартира 126'),
	   (N'353917, г. Нижний Новгород, ул. Хуторская 2-я, дом 92, квартира 379'),
	   (N'301638, г. Покровка, ул. Калитниковский Б. проезд, дом 20, квартира 356'),
	   (N'462882, г. Тасеево, ул. Мирный пер, дом 64, квартира 58'),
	   (N'403659, г. Рыбачий, ул. Амурская, дом 4, квартира 41'),
	   (N'191124, г. Серов, ул. Обыденский 2-й пер, дом 34, квартира 368'),
	   (N'363760, г. Сургут, ул. Вербная, дом 56, квартира 55'),
	   (N'397457, г. Переславское, ул. Лыжный пер, дом 13, квартира 467'),
	   (N'618180, г. Приморск, ул. Угловой пер, дом 53, квартира 306'),
	   (N'612463, г. Покрышкино, ул. Енисейская, дом 80, квартира 56'),
	   (N'624853, г. Одоев, ул. Подъемная, дом 83, квартира 292'),
	   (N'347432, г. Новокузнецк, ул. Космическая, дом 45, квартира 381'),
	   (N'215824, г. Славяновка, ул. Баумана, дом 76, квартира 129'),
	   (N'353338, г. Майское, ул. Вокзальная  (Красносельский), дом 45, квартира 351'),
	   (N'679175, г. Сунтар, ул. Немировича-Данченко, дом 93, квартира 264'),
	   (N'630001, г. Сочи, ул. Теплый Стан, дом 13, квартира 401'),
	   (N'Украина, 141704, г. Саров (Морд.), ул. Долгопрудненское ш, дом 4, квартира 211'),
	   (N'182725, г. Шолоово, ул. Водопроводный пер, дом 18, квартира 184'),
	   (N'676966, г. Алеевка, ул. Андрея Рублева, дом 43, квартира 318'),
	   (N'627225, г. Ольга, ул. Фрезер ш, дом 56, квартира 193'),
	   (N'614521, г. Владивосток, ул. Николоворобинский М. пер, дом 16, квартира 399'),
	   (N'368022, г. Терек, ул. Дубовой Рощи, дом 48, квартира 96'),
	   (N'612162, г. Сосновка, ул. Дубовой Рощи, дом 55, квартира 216'),
	   (N'175404, г. Суровикино, ул. Лесной пер (Красногвардейский), дом 41, квартира 272'),
	   (N'423712, г. Константиновск, ул. Песочная, дом 1, квартира 354'),
	   (N'682906, г. Мокшан, ул. Хорошевский 2-й проезд, дом 18, квартира 119'),
	   (N'624866, г. Хабаровск, ул. Щипковский 4-й пер, дом 59, квартира 39'),
	   (N'624675, г. Прудное, ул. Павлоградский пер, дом 41, квартира 168'),
	   (N'Украина, 452455, г. Усть-Уда, ул. Садовая-Каретная, дом 51, квартира 227'),
	   (N'102002, г. Песчанокопск, ул. Лесхоз 2 (Лесничество), дом 18, квартира 340'),
	   (N'445148, г. Красноярское, ул. Марата  (Красносельский), дом 87, квартира 77'),
	   (N'249051, г. Киселевск, ул. Малый пр-кт (Петроградский), дом 28, квартира 230'),
	   (N'307701, г. Чебоксары, ул. Магнитогорская, дом 5, квартира 84'),
	   (N'194291, г. Навля, ул. Российская, дом 19, квартира 29'),
	   (N'658980, г. Обь, ул. Юрьевский пер, дом 95, квартира 171'),
	   (N'422982, г. Качканар, ул. Покрышкина, дом 57, квартира 259'),
	   (N'396180, г. Канск, ул. Масляный пер, дом 53, квартира 451'),
	   (N'663693, г. Кез, ул. Новорязанское ш, дом 6, квартира 141'),
	   (N'429538, г. Красноармейск, ул. Тельбесская, дом 44, квартира 340'),
	   (N'629325, г. Токаревка, ул. Капсюльное ш, дом 89, квартира 98'),
	   (N'157446, г. Зубова Поляна, ул. Исаковского, дом 20, квартира 45'),
	   (N'665328, г. Вурнары, ул. Сборная, дом 23, квартира 439'),
	   (N'606400, г. Унеча, ул. Петра Алексеева 1-й пер, дом 26, квартира 320'),
	   (N'462226, г. Исянгулово, ул. Фрунзенская наб, дом 69, квартира 363'),
	   (N'425021, г. Чистополь, ул. Морской Пехоты, дом 34, квартира 275'),
	   (N'680022, г. Дульдурга, ул. Лермонтовская пл, дом 89, квартира 352'),
	   (N'307225, г. Бугульма, ул. Дениса Давыдова, дом 63, квартира 279'),
	   (N'309420, г. Усогорск, ул. Старая, дом 53, квартира 311'),
	   (N'669477, г. Старая Майна, ул. Кирпичные Выемки, дом 42, квартира 352'),
	   (N'164699, г. Шали, ул. Ново-Ковалево п, дом 84, квартира 481'),
	   (N'427981, г. Сямжа, ул. Горбунова, дом 13, квартира 341'),
	   (N'Украина, 187509, г. Новобобруйск, ул. 2 Луч, дом 13, квартира 429'),
	   (N'404177, г. Заречный, ул. Телевизионная, дом 52, квартира 300'),
	   (N'398524, г. Целинное, ул. Граничный пер, дом 71, квартира 343'),
	   (N'456081, г. Чернышевское, ул. Кировоградский проезд, дом 66, квартира 229'),
	   (N'181119, г. Луза, ул. Инструментальная (Апраксин двор) линия, дом 66, квартира 456'),
	   (N'141100, г. Нива, ул. Балластный 1-й пер, дом 50, квартира 366'),
	   (N'102330, г. Сосновка, ул. Нижнелихоборский 3-й проезд, дом 37, квартира 107'),
	   (N'215665, г. Топки, ул. Автово ст, дом 70, квартира 93'),
	   (N'369429, г. Райчихинск, ул. Тихомировская, дом 25, квартира 185'),
	   (N'Украина, 446018, г. Копейск, ул. Регировщиков пер, дом 17, квартира 180'),
	   (N'607403, г. Касимов, ул. Маяковского, дом 13, квартира 299'),
	   (N'671941, г. Сонково, ул. Передовиков, дом 13, квартира 9'),
	   (N'663594, г. Тбилисская, ул. Новоостанкинская 2-я, дом 97, квартира 472'),
	   (N'305000, г. Сычевка, ул. Камышенский 9-й пер, дом 22, квартира 278'),
	   (N'182220, г. Островское, ул. Кошкина проезд, дом 55, квартира 489'),
	   (N'Украина, 641086, г. Туринская Слобода, ул. Московская  (Поселок Внуково), дом 16, квартира 205'),
	   (N'309361, г. Солнечный, ул. Красная Горка (3-я линия) пер, дом 81, квартира 486')
;

-- Таблица, для хранения частей адреса
if OBJECT_ID ('[tempdb].[dbo].#loc_02') is not null drop table #loc_02;
create table #loc_02 (
       ROW_ID    int , -- идент. строки
	   [ADDRESS] varchar(250)       -- адрес
)
;

go
declare @ROW_ID as int;
declare @ADDRESS as nvarchar(250);

declare @delimeter as char(1) = ',';     -- Переменная, для хранения символа разделителя
declare @PartOfAddress as nvarchar(250); -- Переменная, для хранения части адреса 
declare @String as nvarchar(250);        -- Переменная, для хранения адреса 

-- Объявление курсора
declare [Address] cursor fast_forward read_only for 
select l.ROW_ID,
       l.[ADDRESS]
  from #loc_01 l;

-- Открыть курсор
open [Address];

-- Прокручивание курсора на первую строку
fetch next from [Address] into @ROW_ID, @ADDRESS;

-- Циклическое прокручивание строк (1)
while @@FETCH_STATUS = 0
	begin
	    set @String = @ADDRESS;

		-- Вложенный цикл (2) - разделения строки по запятой
		while CHARINDEX(@delimeter, @String) != 0
			begin
			    
				-- 1
				set @partOfAddress =SUBSTRING(@String, 1, CHARINDEX(@delimeter, @String) -1)
				
				insert into #loc_02 (ROW_ID, ADDRESS)
		        values(@ROW_ID, @partOfAddress);

				-- 2
				set @string = SUBSTRING(@string, CHARINDEX(@delimeter, @string)+1, 250);

				if CHARINDEX(@delimeter, @String) = 0
					begin
						insert into #loc_02(ROW_ID, ADDRESS)
						values(@ROW_ID, @String)
					end


			end
		
		
		fetch next from [Address] into @ROW_ID, @ADDRESS;
	end

close [Address];
deallocate [Address];

select [ADDRESS],
       COUNT([ADDRESS])
  from #loc_02 l
 group by [ADDRESS]
 order by COUNT([ADDRESS]) desc;

--======================================================================================================================================================================
-- Разворачивание данных c помощью стандартных средства - case
with cte as
(
select convert(date, h.OrderDate) as [OrderDate],
       h.CustomerID,
       sum(h.SubTotal)            as [TOTAL]
  from [Sales].[SalesOrderHeader] as h
 where h.OrderDate between '20110801' and '20110831 23:59:59'
 group by convert(date, h.OrderDate),
          h.CustomerID
)
/*
select CustomerID,
       sum(case OrderDate when '2011-08-01' then TOTAl end) as [2011-08-01],
	   sum(case OrderDate when '2011-08-02' then TOTAl end) as [2011-08-02],
	   sum(case OrderDate when '2011-08-03' then TOTAl end) as [2011-08-03],
	   sum(case OrderDate when '2011-08-04' then TOTAl end) as [2011-08-04],
	   sum(case OrderDate when '2011-08-05' then TOTAl end) as [2011-08-05],
	   sum(case OrderDate when '2011-08-06' then TOTAl end) as [2011-08-06],
	   sum(case OrderDate when '2011-08-07' then TOTAl end) as [2011-08-07],
	   sum(case OrderDate when '2011-08-08' then TOTAl end) as [2011-08-08],
	   sum(case OrderDate when '2011-08-09' then TOTAl end) as [2011-08-09],
	   sum(case OrderDate when '2011-08-10' then TOTAl end) as [2011-08-10],
	   sum(case OrderDate when '2011-08-12' then TOTAl end) as [2011-08-12],
	   sum(case OrderDate when '2011-08-13' then TOTAl end) as [2011-08-13],
	   sum(case OrderDate when '2011-08-14' then TOTAl end) as [2011-08-14],
	   sum(case OrderDate when '2011-08-15' then TOTAl end) as [2011-08-15],
	   sum(case OrderDate when '2011-08-16' then TOTAl end) as [2011-08-16],
	   sum(case OrderDate when '2011-08-17' then TOTAl end) as [2011-08-17],
	   sum(case OrderDate when '2011-08-18' then TOTAl end) as [2011-08-18],
	   sum(case OrderDate when '2011-08-19' then TOTAl end) as [2011-08-19],
	   sum(case OrderDate when '2011-08-20' then TOTAl end) as [2011-08-20],
	   sum(case OrderDate when '2011-08-21' then TOTAl end) as [2011-08-21],
	   sum(case OrderDate when '2011-08-22' then TOTAl end) as [2011-08-22],
	   sum(case OrderDate when '2011-08-23' then TOTAl end) as [2011-08-23],
	   sum(case OrderDate when '2011-08-24' then TOTAl end) as [2011-08-24],
	   sum(case OrderDate when '2011-08-25' then TOTAl end) as [2011-08-25],
	   sum(case OrderDate when '2011-08-26' then TOTAl end) as [2011-08-26],
	   sum(case OrderDate when '2011-08-27' then TOTAl end) as [2011-08-27],
	   sum(case OrderDate when '2011-08-28' then TOTAl end) as [2011-08-28],
	   sum(case OrderDate when '2011-08-29' then TOTAl end) as [2011-08-29],
	   sum(case OrderDate when '2011-08-30' then TOTAl end) as [2011-08-30],
	   sum(case OrderDate when '2011-08-31' then TOTAl end) as [2011-08-31]
  from cte
 group by CustomerID
 order by CustomerID asc;
 */

-- Разворачивание данных с помощью встроенных средств - pivot

select p.*
  from cte
  pivot(sum([TOTAL]) for OrderDate in  ([2011-08-01], [2011-08-02], [2011-08-03],
                                        [2011-08-04], [2011-08-05], [2011-08-06], 
										[2011-08-07], [2011-08-08], [2011-08-09],
                                        [2011-08-10], [2011-08-12], [2011-08-13], 
										[2011-08-14], [2011-08-15], [2011-08-16], 
										[2011-08-17], [2011-08-18], [2011-08-19], 
										[2011-08-20], [2011-08-21], [2011-08-22], 
										[2011-08-23], [2011-08-24], [2011-08-25],
                                        [2011-08-26], [2011-08-27], [2011-08-28], 
										[2011-08-29], [2011-08-30], [2011-08-31])) as p order by CustomerID asc
--======================================================================================================================================================================
-- Определение переменной для хранения динамического SQL
declare @SQL as nvarchar(max); 
    set @SQL = N'select *
                  from (select convert(date, h.OrderDate) as [OrderDate],
                               CustomerID,
		                       h.SubTotal
                          from [Sales].[SalesOrderHeader] h
						 where h.OrderDate between ''20110801'' and ''20110831 23:59:59'') as q
				 pivot(sum(SubTotal) for [OrderDate] in (';

-- Определени переменной для хранения дат из курсора
declare @OrderDate as date;

-- Обьявление курсора - наполнение курсора датами за необходимый период
declare dates cursor fast_forward read_only for
select distinct 
       convert(date, h.OrderDate) 
  from [Sales].[SalesOrderHeader] h
 where h.OrderDate between '20110801' and '20110831 23:59:59'
 order by convert(date, h.OrderDate) asc;

-- Открытие курсора
open dates;

-- Прокручивание курсора на первую строку
fetch next from dates into @OrderDate;

-- Циклическое прокручивание курсора - перебор дат
while @@FETCH_STATUS = 0
	begin
		set @SQL = @SQL + '['+ CONVERT(nvarchar(10), @OrderDate)+ ']';


		fetch next from dates into @OrderDate;

		if @@FETCH_STATUS = 0
			set @SQL = @SQL + N',';
	end

set @SQL = @SQL + ')) as p;';

-- Закрытие курсора
close dates;

-- Освобождение курсора
deallocate dates;

execute sp_executesql @SQL;
print @SQL;

--======================================================================================================================================================================
with cte as 
(
select *
  from (select convert(date, h.OrderDate) as [OrderDate],
               CustomerID,
		       h.SubTotal
          from [Sales].[SalesOrderHeader] h
	     where h.OrderDate between '20110801' and '20110831 23:59:59') as q
		 pivot(sum(SubTotal) for [OrderDate] in ([2011-08-01],[2011-08-02],[2011-08-03],[2011-08-04],[2011-08-05],[2011-08-06],
		                                         [2011-08-07],[2011-08-08],[2011-08-09],[2011-08-10],[2011-08-12],[2011-08-13],
												 [2011-08-14],[2011-08-15],[2011-08-16],[2011-08-17],[2011-08-18],[2011-08-19],
												 [2011-08-20],[2011-08-21],[2011-08-22],[2011-08-23],[2011-08-24],[2011-08-25],
												 [2011-08-26],[2011-08-27],[2011-08-28],[2011-08-29],[2011-08-30],[2011-08-31])) as p
) 
-- Отмена разворачивания данных с помощью встроенных средств
select * 
  from (
select c.CustomerID,
       d.OrderDate,
	   case d.OrderDate when '2011-08-01' then [2011-08-01] 
	                    when '2011-08-02' then [2011-08-02] 
						when '2011-08-03' then [2011-08-03] 
						when '2011-08-04' then [2011-08-04] 
						when '2011-08-05' then [2011-08-05] 
						when '2011-08-06' then [2011-08-06] 
						when '2011-08-07' then [2011-08-07] 
						when '2011-08-08' then [2011-08-08] 
						when '2011-08-09' then [2011-08-09] 
						when '2011-08-10' then [2011-08-10] 
						when '2011-08-12' then [2011-08-12] 
						when '2011-08-13' then [2011-08-13] 
						when '2011-08-14' then [2011-08-14] 
						when '2011-08-15' then [2011-08-15] 
						when '2011-08-16' then [2011-08-16] 
						when '2011-08-17' then [2011-08-17] 
						when '2011-08-18' then [2011-08-18] 
						when '2011-08-19' then [2011-08-19] 
						when '2011-08-20' then [2011-08-20] 
						when '2011-08-21' then [2011-08-21] 
						when '2011-08-22' then [2011-08-22] 
						when '2011-08-23' then [2011-08-23] 
						when '2011-08-24' then [2011-08-24] 
						when '2011-08-25' then [2011-08-25] 
						when '2011-08-26' then [2011-08-26] 
						when '2011-08-27' then [2011-08-27] 
						when '2011-08-28' then [2011-08-28] 
						when '2011-08-29' then [2011-08-29] 
						when '2011-08-30' then [2011-08-30] 
						when '2011-08-31' then [2011-08-31] end as [SubTotal]

  from cte c
  cross join (values ('2011-08-01'), ('2011-08-02'), ('2011-08-03'),
  ('2011-08-04'), ('2011-08-05'), ('2011-08-06'), ('2011-08-07'), ('2011-08-08'),
  ('2011-08-09'), ('2011-08-10'), ('2011-08-12'), ('2011-08-13'), ('2011-08-14'), 
  ('2011-08-15'), ('2011-08-16'), ('2011-08-17'), ('2011-08-18'), ('2011-08-19'),
  ('2011-08-20'), ('2011-08-21'), ('2011-08-22'), ('2011-08-23'), ('2011-08-24'),
  ('2011-08-25'), ('2011-08-26'), ('2011-08-27'), ('2011-08-28'), ('2011-08-29'),
  ('2011-08-30'), ('2011-08-31')) as d (OrderDate)
  ) q 
  where q.SubTotal is not null;


-- Отмена разворачивания данных - встроенные средства - unpivot
with cte as 
(
select *
  from (select convert(date, h.OrderDate) as [OrderDate],
               CustomerID,
		       h.SubTotal
          from [Sales].[SalesOrderHeader] h
	     where h.OrderDate between '20110801' and '20110831 23:59:59') as q
		 pivot(sum(SubTotal) for [OrderDate] in ([2011-08-01],[2011-08-02],[2011-08-03],[2011-08-04],[2011-08-05],[2011-08-06],
		                                         [2011-08-07],[2011-08-08],[2011-08-09],[2011-08-10],[2011-08-12],[2011-08-13],
												 [2011-08-14],[2011-08-15],[2011-08-16],[2011-08-17],[2011-08-18],[2011-08-19],
												 [2011-08-20],[2011-08-21],[2011-08-22],[2011-08-23],[2011-08-24],[2011-08-25],
												 [2011-08-26],[2011-08-27],[2011-08-28],[2011-08-29],[2011-08-30],[2011-08-31])) as p
) 
select *
  from cte c
unpivot (SubTotal for OrderDate in ([2011-08-01],[2011-08-02],[2011-08-03],[2011-08-04],[2011-08-05],[2011-08-06],
		                                         [2011-08-07],[2011-08-08],[2011-08-09],[2011-08-10],[2011-08-12],[2011-08-13],
												 [2011-08-14],[2011-08-15],[2011-08-16],[2011-08-17],[2011-08-18],[2011-08-19],
												 [2011-08-20],[2011-08-21],[2011-08-22],[2011-08-23],[2011-08-24],[2011-08-25],
												 [2011-08-26],[2011-08-27],[2011-08-28],[2011-08-29],[2011-08-30],[2011-08-31])) as u
--======================================================================================================================================================================
select e.JobTitle,
       e.HireDate,
	   COUNT(distinct e.BusinessEntityID) 
 from [HumanResources].[Employee] e
where HireDate between '20081201' and '20081207'
 group by e.JobTitle,
          e.HireDate
 order by  COUNT(distinct e.BusinessEntityID)  desc


 -- Ян
 use SQL221
---------стандартные средства----------------
with cte as 
(
select JobTitle,
       HireDate,
    COUNT(distinct BusinessEntityID) as [CountEmployee] 
 from [HumanResources].[Employee]
where HireDate between '20081201' and '20081207'
 group by JobTitle,
          HireDate
 )
 --select * from cte
 select JobTitle,
 sum(case HireDate when '2008-12-01' then CountEmployee end) as [2008-12-01],
 sum(case HireDate when '2008-12-02' then CountEmployee end) as [2008-12-02],
 sum(case HireDate when '2008-12-03' then CountEmployee end) as [2008-12-03],
 sum(case HireDate when '2008-12-04' then CountEmployee end) as [2008-12-04],
 sum(case HireDate when '2008-12-05' then CountEmployee end) as [2008-12-05],
 sum(case HireDate when '2008-12-06' then CountEmployee end) as [2008-12-06],
 sum(case HireDate when '2008-12-07' then CountEmployee end) as [2008-12-07]
 from cte
 group by JobTitle,HireDate
 order by JobTitle asc;

---------pivot----------------

with cte as 
(
select JobTitle,
       HireDate,
    COUNT(distinct BusinessEntityID) as [CountEmployee] 
 from [HumanResources].[Employee]
where HireDate between '20081201' and '20081207'
 group by JobTitle,
          HireDate
 )

select *
  from cte
  pivot(sum([CountEmployee] ) for HireDate in  ([2008-12-01],[2008-12-02],[2008-12-03],[2008-12-04],
                                                [2008-12-05],[2008-12-06],[2008-12-07])) as p order by JobTitle asc
--==================================================================================================
-- Ян
---------отмена стандартными средствами----------------
with cte as (
select *
  from (select e.HireDate,
               e.JobTitle,
     -- e.BusinessEntityID as [CountEmployee] 
            count (distinct e.BusinessEntityID) as [CountEmployee] 
               from [HumanResources].[Employee] as e
               where e.HireDate between '20081201' and '20081207'
      group by e.JobTitle,e.HireDate) as q
  pivot(sum([CountEmployee] ) for HireDate in  ([2008-12-01],[2008-12-02],[2008-12-03],[2008-12-04],
                                                [2008-12-05],[2008-12-06],[2008-12-07])) as w )

--select * from cte


select * 
  from (
       select  c.JobTitle,
               d.HireDate,
    case    d.HireDate  when '2008-12-01' then [2008-12-01] 
                        when '2008-12-02' then [2008-12-02] 
         when '2008-12-03' then [2008-12-03] 
         when '2008-12-04' then [2008-12-04] 
         when '2008-12-05' then [2008-12-05] 
         when '2008-12-06' then [2008-12-06] 
         when '2008-12-07' then [2008-12-07] end as [CountEmployee]
  from cte c
  cross join (values ('2008-12-01'), ('2008-12-02'), ('2008-12-03'),
  ('2008-12-04'), ('2008-12-05'), ('2008-12-06'), ('2008-12-07')) as d (HireDate)
  ) q 
  where q.CountEmployee is not null;

  ---------отмена unpivot----------------
  with cte as (
select *
  from (select e.HireDate,
               e.JobTitle,
     -- e.BusinessEntityID as [CountEmployee] 
            count (distinct e.BusinessEntityID) as [CountEmployee] 
               from [HumanResources].[Employee] as e
               where e.HireDate between '20081201' and '20081207'
      group by e.JobTitle,e.HireDate) as q
  pivot(sum([CountEmployee] ) for HireDate in  ([2008-12-01],[2008-12-02],[2008-12-03],[2008-12-04],
                                                [2008-12-05],[2008-12-06],[2008-12-07])) as w )

--select * from cte

select *
  from cte c
unpivot (CountEmployee for HireDate in ([2008-12-01],[2008-12-02],[2008-12-03],[2008-12-04],
                                                [2008-12-05],[2008-12-06],[2008-12-07])) as q
