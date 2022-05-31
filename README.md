#### SQL
file`s of project
.
https://www.sql-ex.ru/index.php?Lang
   
##### Импорт postgresDB
   https://habr.com/ru/post/658153/
  
-------------------------------------
   BackUP:
   - удалить старую БД (битую):
   - Создадим на сервере новую базу данных, в которую будем восстанавливать резервную копию. Перед этим посмотрим список баз данных на сервере:
   #### psql -U postgres -l
   - Создаем новую базу данных DEMO:
   #### createdb --username postgres -T template0 demo
   - Базу данных создали. Теперь загружаем в нее наш бэкап 1с:
   #### psql -U postgres base1c-restored < demo20205301211.sql   
  
  
  
https://serveradmin.ru/bekap-i-vosstanovlenie-bazyi-1s-v-bd-postgresql/

   
 ----------------------
 ### 1c
 https://infostart.ru/1c/articles/1187165/<br>
 https://serveradmin.ru/bekap-i-vosstanovlenie-bazyi-1s-v-bd-postgresql/#_PostgreSQL_Backup
 
 
