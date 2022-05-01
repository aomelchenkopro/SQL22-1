--====================================================ДЗ 5 урок Найда Я.С.=========================================

USE SQL221

select 
p.color ,count(distinct p.productid) as [Colorqty] 
	from [Production].[Product] as p
	where p.color is not null
	group by p.color
	having count(distinct p.productid) > 1
	order by count(distinct p.productid) desc
GO 

/*Вопросы 
1) Можно ли обратиться как представлению колонки?
2) По гитХабу - один файл, одна ветка мэин?
	Добивка прошлого ДЗ
	Выбор строки при загрузке, выгрузке OK
bcp SQL221.BCP_Nauda.Title in C:\Users\yanna\Desktop\12345.txt -c -S 159.224.194.250 -U sa -P rLC9s39J7h -F 2 - Загрузка с определённой строки где F номер строки (Можно добавить поа анологии L это будет последняя строка)
	Выбор строки при выгрузке
bcp SQL221.BCP_Nauda.Title out C:\Users\yanna\Desktop\12345.txt -c -S 159.224.194.250 -U sa -P rLC9s39J7h -F 2 -L 3 (Важно указывать первый параметр F(С какой строки. иначе он не учитывается)
	Кирилица
bcp SQL221.BCP_Nauda.Title in C:\Users\yanna\Desktop\12345.txt -w -S 159.224.194.250 -U sa -P rLC9s39J7h
Получилось без 
-t\t - разделитель столбцов - tab
-r\n - разделитель строк - перенос строки
Главное правельная кодировка в нотепад
*/