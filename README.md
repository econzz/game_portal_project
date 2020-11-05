##### Nelson's HTML5 game portal website

A simple game portal website made using ruby on rails 5.2

Some blog article about the project: (in Japanese)
https://neruchanz.hatenablog.com/archive/category/HTML5%E3%82%B2%E3%83%BC%E3%83%A0%E3%83%9D%E3%83%BC%E3%82%BF%E3%83%AB%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88

### Link To see
https://portal.neruchan.com

admin page
https://portal.neruchan.com/admin
id: test@test.com
pass: Test12345

### Functionality
Admin Page
1) add, update, delete HTML5 games information
2) upload HTML5 game bundle .zip + assets png
3) add, update categories of games
4) see how many plays each game has

Front Side
1) List of uploaded HTML5 games
2) Play HTML5 games
3) Leaderboard score for each game
4) list by categories for each games

SDK Side
1) register/update player infos
2) generate player ID from browser information
3) login player
4) register score
5) show leaderboard
6) show/hide home buttons

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

### Initialize the database

```shell
rails db:create db:migrate
```

### Ruby version
2.6.6

### Rails version
5.2.0


