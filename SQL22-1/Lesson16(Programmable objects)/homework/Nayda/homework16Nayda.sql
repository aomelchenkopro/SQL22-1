/*C помощью цикла, разделите строку "США, Сиэтл, 7890 - 20th Ave E Apt 2A" на части по разделительному символу ",".
- Задействуйте переменную.
- Задействуйте цикл.
- Задействуйте строковые функции charindex, substring.

CHARINDEX ( expressionToFind , expressionToSearch [ , start_location ] )
определяет порядковый номер символа, с которого начинается вхождение подстроки в строку.

SUBSTRING ( expression ,start , length )
возвращает для строки подстроку указанной длины с заданного символа.*/


declare @MyTable as table ([Text] nvarchar(50));
declare @Index as int = 0;
declare @ShareText as nvarchar(50) = N'США, Сиэтл, 7890 - 20th Ave E Apt 2A'+ ',';
while len(@ShareText) > 1
     begin
     insert into @MyTable([Text])
  values (SUBSTRING((@ShareText),0,CHARINDEX(',', @ShareText,0)));
  set @ShareText = SUBSTRING(@ShareText,CHARINDEX(',', @ShareText,0)+1,len(@ShareText))
  set @Index = @Index +1 
  if CHARINDEX(',', @ShareText,0) = 1 
  set @ShareText = SUBSTRING(@ShareText,CHARINDEX(',', @ShareText,0),len(@ShareText))
 end

select * from @MyTable
go 
