## Project-final
[![My Skills](https://skillicons.dev/icons?i=idea,java,postgres,hibernate,maven,html,spring,docker)](https://skillicons.dev)

### JiraRush

JavaRush University final project

### Запуск приложения

1. Клонировать себе на машину проект.
2. Запустить локально сервер БД (PostgreSQL). Запуск сделать через docker.
- Для запуска понадобиться 2 контейнера с БД. 
- Первый для запуска приложения (профиль prod), второй для билда и тестов (профиль test). 
- Соответствующие команды:
```
docker run -p 5432:5432 --name postgres-db -e POSTGRES_USER=jira -e POSTGRES_PASSWORD=JiraRush -e POSTGRES_DB=jira -e PGDATA=/var/lib/postgresql/data/pgdata -v ./pgdata:/var/lib/postgresql/data -d postgres
docker run -p 5433:5432 --name postgres-db-test -e POSTGRES_USER=jira -e POSTGRES_PASSWORD=JiraRush -e POSTGRES_DB=jira-test -e PGDATA=/var/lib/postgresql/data/pgdata -v ./pgdata-test:/var/lib/postgresql/data -d postgres
```
3. Сбилдить приложение: 
```
mvn clean install
```
4. Запустить Spring Boot приложение (JiraRushApplication) с профилем `prod`

### Список задач 
> complete - &check;
> 
> not complete - &cross;

&check; 1. Разобраться со структурой проекта (onboarding).

&check; 2. Удалить социальные сети: vk, yandex.

&cross; 3. Вынести чувствительную информацию в отдельный проперти файл:
   - логин
   - пароль БД
   - идентификаторы для OAuth регистрации/авторизации
   - настройки почты
   Значения этих проперти должны считываться при старте сервера из переменных окружения машины.

&cross; 4. Переделать тесты так, чтоб во время тестов использовалась in memory БД (H2), а не PostgreSQL. Для этого нужно определить 2 бина, и выборка какой из них использовать должно определяться активным профилем Spring. H2 не поддерживает все фичи, которые есть у PostgreSQL, поэтому тебе прийдется немного упростить скрипты с тестовыми данными.

&cross; 5. Написать тесты для всех публичных методов контроллера ProfileRestController. Хоть методов только 2, но тестовых методов должно быть больше, т.к. нужно проверить success and unsuccess path.

&cross; 6. Сделать рефакторинг метода com.javarush.jira.bugtracking.attachment.FileUtil#upload чтоб он использовал современный подход для работы с файловой системой.

&cross; 7. Добавить новый функционал: добавления тегов к задаче (REST API + реализация на сервисе). Фронт делать необязательно. Таблица task_tag уже создана.

&cross; 8. Добавить подсчет времени сколько задача находилась в работе и тестировании. Написать 2 метода на уровне сервиса, которые параметром принимают задачу и возвращают затраченное время:
        
- Сколько задача находилась в работе (ready_for_review минус in_progress ).
        
- Сколько задача находилась на тестировании (done минус ready_for_review).

Для написания этого задания, нужно добавить в конец скрипта инициализации базы данных changelog.sql 3 записи в таблицу ACTIVITY:
`insert into ACTIVITY ( ID, AUTHOR_ID, TASK_ID, UPDATED, STATUS_CODE ) values ...`

Со статусами:
- время начала работы над задачей – in_progress
- время окончания разработки - ready_for_review
- время конца тестирования - done

&cross; 9. Написать Dockerfile для основного сервера

&cross; 10. Написать docker-compose файл для запуска контейнера сервера вместе с БД и nginx. Для nginx используй конфиг-файл config/nginx.conf. При необходимости файл конфига можно редактировать.

&cross; 11. Добавить локализацию минимум на двух языках для шаблонов писем (mails) и стартовой страницы index.html.

&cross; 12. Переделать механизм распознавания «свой-чужой» между фронтом и беком с JSESSIONID на JWT. Из сложностей – придется переделать отправку форм с фронта, чтоб добавлять хедер аутентификации.