/*
C помощью цикла, разделите строку "США, Сиэтл, 7890 - 20th Ave E Apt 2A" на части по разделительному символу ",".
- Задействуйте переменную.
- Задействуйте цикл.
- Задействуйте строковые функции charindex, substring.

CHARINDEX ( expressionToFind , expressionToSearch [ , start_location ] )
определяет порядковый номер символа, с которого начинается вхождение подстроки в строку.

SUBSTRING ( expression ,start , length )
возвращает для строки подстроку указанной длины с заданного символа.
*/

------------------------------------------------1----------------------------------------------------------
-- Переменные
declare @delimiter   as char(1)      = ',';                                               -- Разделитель текста
declare @string      as varchar(100) = 'one, one, two, one, two, three, one, two, three'; -- Исходная строка
declare @string_part as varchar(100) = '';                                                -- Хранение части строк
declare @DYNAMIC_SQL as varchar(1000)= 'select';
------------------------------------------------2----------------------------------------------------------
-- Циклическое выполение инструций
while charindex(',', @string) != 0 
begin

----------------------------------------------------------------------
set @string_part = SUBSTRING(@string,1 ,charindex(@delimiter, @string) - 1 );
----------------------------------------------------------------------

select @string_part;
-- Динамический SQL
--set @DYNAMIC_SQL = @DYNAMIC_SQL +' '+' '' '+@string_part+' '' ,';

----------------------------------------------------------------------
set @string = SUBSTRING(@string, charindex(@delimiter, @string) + 1, 100);
----------------------------------------------------------------------
if charindex(@delimiter, @string) = 0 
begin
print @string;
-- set @DYNAMIC_SQL = @DYNAMIC_SQL +' '+' '' '+@string_part+' '' ';
end

end