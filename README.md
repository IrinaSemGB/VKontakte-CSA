# VKontakte-CSA
Клиент-серверные iOS-приложения, Realm

Приложение на основе социальной сети ВКонтакте, для получения данных использует API VK, для их хранения использует Realm

Для входа необходимо авторизоваться под собственных аккаунтом ВКонтакте или использовать(зарегистрировать) тестовый аккаунт

На экране профиля Вы увидете свои данные - фото, имя, статус, день рождения и местоположение; если эти данные заполнены Вами и к ним разрешен доступ

На экране друзей доступен список друзей пользователя с id6492 (данный id указан в документации на сайте ВКонтакте в качестве примера API-запроса), 
  друзья разделены по секциям, секции формируются по первой букве имени, друга можно удалить свайпом влево

На экране сообществ доступны все группы пользователя id6492, реализована функция поиска группы по названию

Для первого запуска приложения, возможно, понадобится установить/обновить pod-ы


=======================



The application is based on the social network VKontakte, uses the VKontakte API to receive data, and uses Realm to store it

To enter, you need to log in with your VKontakte account or use (register) a test account

On the profile screen, you will see your details - photo, name, status, birthday and location; if this data is filled in by you and access is allowed

On the friends screen, a list of friends of the user with id6492 is available 
  (this identifier is indicated in the documentation on the VKontakte website as an example of an API request),
  friends are divided into sections, sections are formed by the first letter of the name, a friend can be removed by swiping to the left

All groups of user id6492 are available on the community screen, the function of group search by name has been implemented

For the first launch of the application, you may need to install / update pods
