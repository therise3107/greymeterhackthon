# greymeterhackthon
this is the app api which i used to compete in 2015 hackthon 

# Approach

There are many ways to do it but i prefered pure ruby.The code is quite simple , since we did not needed any views so there is only json api running on top of rails.

## App working

    Server pings the app at /ping
   
    our app sends the json response as {"ok": true}

    server send the value of our coordinate(y), opponent coordinate(o) and no of blocks(b) at /start for ex     /start?b=8&y=1%7C1&c=8%7C8

    our app has to extract the sever response and intialize the game and sends the reponse in form of json as {"ok": true}

    server starts the game by hitting /play and passing the corrdinate value of opponent (if serer send the same value o then it is our first turn otherwise its our opponent) ex /play?m=8%7C8

    we sends the response back the server in the json format of {"m": "1|1"}

    In our def start ... end we calculate the total  no of moves and store them with their position

    Whenever we hit a position we delete that coordinate from our total moves so that no position is traversed twise

    We do the same with our opponent move we store his last position and delete it at the end our def play ... end

    We store the adjacent position w.r.t to current position of our current move and our opponent moves

    If our oponents current position is in our adjacentnode array we make our move and set our current position to m and we beat our opponent

    In the second loop we check if we have any common adjancent position if yes we traverse to the remaining position except the common one(then we will be just one move away from and our opponent and we may loose)

    If all conditon fails then we set our current position to our_adjacent_position which has the heighest no of available adjacent nodes 
   






# Challenge


THE BATTLE OF THE KINGS

A. The Game
There is a board game played between two players. The board has nXn equal squares, where 8 <= n <= 15 (similar to a chess board).
Only two kings will be placed on the board at the starting of the game (one at 1,1 and second at n,n position).
The kings can move one square in any direction - up, down, to the sides, and diagonally, just like chess.
Each square can be visited at-most once by either of the kings.
The king who gets killed, or is out of moves loses the game.

B. What you need to do?
You need to write a bot, which can play the game on your behalf. And expose this bot as a webservice.
Your webservice should run on port 8080 and expose three APIs:
Url	Type	Parameter	Sample Response	Purpose
/ping	GET	--	{"ok": true}	To let us know that your bot server is alive
/start	GET	y,o,g	{"ok": true}	For you to initialize the round. Here y would indicate position of your king (eg: 1|1), o indicates position of opponentâs king (eg: n|n), and g indicates size of the grid.
/play	GET	m	{"m":"1|2"}	m : Move made by your opponent. Your response would convey your next move.
Note: By convention all positions are represented as x|y where x and y are respective coordinates on the board. Bottom left board is 1|1.
C. The Rules
At the beginning, all players would be given a rating of 8.
After a game, half of the rating points of losing player would be transferred to the winning player.
For first game between any two players, each of the player will be awarded one additional rating point.
A game will consist of two rounds with each player getting the first move in one round. To win a game, you need to win both the rounds.
You will see the leaderboard on http://hackathon.unicommerce.com. Here youâll be able to challenge any of the available players. A player is available for challenge if his bot server is alive and he has marked himself as âAvailable for Challengeâ. You can mark yourself as âAvailable for Challengeâ using the button provided on the panel.
At the end of each game, you will be marked as âNot Available For Challengeâ. Youâll need to make yourself available for challenge to play next game.
There can be at most 5 games between any two players.
You can see the reply of any of the games in the âGames Arenaâ tab.
For first game between any two players, each of the player will be awarded one additional rating point.
A game will consist of two rounds with each player getting the first move in one round. To win a game, you need to win both the rounds.
You will see the leaderboard on http://hackathon.unicommerce.com. Here youâll be able to challenge any of the available players. A player is available for challenge if his bot server is alive and he has marked himself as âAvailable for Challengeâ. You can mark yourself as âAvailable for Challengeâ using the button provided on the panel.
At the end of each game, you will be marked as âNot Available For Challengeâ. Youâll need to make yourself available for challenge to play next game.
There can be at most 5 games between any two players.
You can see the reply of any of the games in the âGames Arenaâ tab.

## Result

  the api was faster than any of opponent team the avg response time of app was 23ms the next best response time was 54ms (node.js) . Though i did not win the hackthon but it was quite satisfying! 



