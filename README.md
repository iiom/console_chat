﻿# Консольный чат
Первоначально был просто консольный чат без доп библиотек и написанием sql запросов в ручную. 
В псоледствии впилена ActiveRecord библиотека и передача ей всех sql запросов к бд. 
Добавлены валидации. Аутентификации. Подключен гем шифрования пароля.

*Программа простой консольный чат*
 * Запись в SQLite
 * Регистрация
 * Сообщения написать/прочитать общие/личные (вывод только не прочитаных сообщений) 
 * Подключение библиотеки ActiveRecord

## Установка Используемая Ruby от:
``` ruby 2.4.1 ```

### Перед запуском выполнить миграцию
``` bundle ```
``` rake db:migrate ```

### Использвоание Запуск из консоли
``` ruby console_chat.rb ```