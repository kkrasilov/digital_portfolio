## Digital Portfolio
___
Digital Portfolio - это приложение на базе Rails, позволяющее пользователям создавать свои портфолио, награды и проекты, а HR - легко находить людей для команд.

### Стек технологий
- Ruby: 2.7.5
- Rails: 7.0
- JS Bundler: Vite
### Установка и настройка
Предварительные требования
- Ruby 2.7.5
- Rails 7.0
- Node.js и npm (для Vite)
- PostgreSQL (или другой поддерживаемый реляционный СУБД)
#### Шаги установки
Клонируйте репозиторий:
```
git clone https://github.com/your-username/digital-portfolio.git
cd digital-portfolio
```
Установите зависимости:
```
bundle install
npm install
```
Настройте базу данных:

Создайте файл `config/database.yml` на основе `config/database.yml.example` и внесите необходимые изменения для вашей среды. Затем выполните миграции:
```
rails db:create
rails db:migrate
```
Запустите сервер разработки:
```
rails server
```
В отдельном терминале запустите Vite:
```
bin/vite dev
```
Приложение должно быть доступно по адресу http://localhost:3000.

