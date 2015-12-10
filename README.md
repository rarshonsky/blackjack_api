#Blackjack API

* To start a game:
```curl localhost:3000/api/game_api -b cook.txt -c cook.txt ```

* To hit:
```curl localhost:3000/api/game_api -b cook.txt -c cook.txt --data "game_action=hit" -X POST```

* To stay:
```curl localhost:3000/api/game_api -b cook.txt -c cook.txt --data "game_action=stay" -X POST```

* Run server locally:
```rails s```

* Run specs:
```rspec ```
