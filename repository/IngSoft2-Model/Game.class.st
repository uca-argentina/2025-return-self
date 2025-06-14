"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'setOfDie',
		'board',
		'turnManager',
		'battleManager',
		'positionManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Game class >> lapHasToBeGreaterThanZeroAndInteger: aNumberOfLaps [

	aNumberOfLaps > 0 ifFalse: [
		Error signal:
			'The amount of laps cannot be lower than 1 or a float number.' ]
]

{ #category : 'testing' }
Game class >> mustHaveAtLeastTwoPlayers: aGroupOfPlayers [

	aGroupOfPlayers size < 2 ifTrue: [
		Error signal: 'You cant play with less than two players.' ]
]

{ #category : 'creation' }
Game class >> playedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps [

	| aGroupOfXPlayers |
	aGroupOfXPlayers := aGroupOfPlayers asOrderedCollection.
	self mustHaveAtLeastTwoPlayers: aGroupOfXPlayers.
	self lapHasToBeGreaterThanZeroAndInteger: laps.
	self twoPlayersCantHaveTheSameId: aGroupOfXPlayers.
	^ self new
		  initializePlayedBy: aGroupOfXPlayers asArray
		  withBoard: aBoard
		  withSetOfDie: aSetOfDie
		  withLaps: laps
]

{ #category : 'testing' }
Game class >> twoPlayersCantHaveTheSameId: aGroupOfPlayers [
	"when passed to Set, repeated values are cleaned"

	(aGroupOfPlayers collect: [ :each | each id ]) size
	= (aGroupOfPlayers collect: [ :each | each id ]) asSet size ifFalse: [
		Error signal: 'You cant have different players with the same ID.' ]
]

{ #category : 'play interface' }
Game >> checkIfBattle: activePlayer [

	| playersToEngage playerWhoLost |
	playersToEngage := positionManager playerInSamePositionThan:
		                   activePlayer.
	playersToEngage = 2 ifFalse: [ ^ self ].
	playerWhoLost := battleManager
		                 engage: playersToEngage
		                 inBattleUsing: setOfDie.
	playerWhoLost needsRecovery ifTrue: [
		turnManager addTwoSkipsTo: playerWhoLost ].
	positionManager resetLapTo: playerWhoLost
]

{ #category : 'comparing' }
Game >> checkIfRecoveryNeeded: aPlayer [

	turnManager checkNoTurnsToSkip ifTrue: [ battleManager resetShieldsAfter2Turns: aPlayer ]
]

{ #category : 'initialization' }
Game >> initializePlayedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: anAmountOfLaps [

	turnManager := TurnManager createWith: aGroupOfPlayers.
	battleManager := BattleManager createWith: aGroupOfPlayers.
	positionManager := PositionManager createWith: aGroupOfPlayers and: aBoard totalTiles and: anAmountOfLaps.
	setOfDie := aSetOfDie.
	board := aBoard.
	playersFeature := aGroupOfPlayers
]

{ #category : 'testing' }
Game >> isWinner: aPlayerName [
	"Used for testing"

	| aPlayer |
	aPlayer := self findShipReference: positionManager winner.
	^ aPlayer equalsName: aPlayerName
]

{ #category : 'interaction loop' }
Game >> nextPlayerSkipsTurn [

	| activePlayer |
	positionManager stillPlaying ifFalse: [ ^ self findShipReference: positionManager winner ].
	turnManager nextPlayerTurnBegins.
	activePlayer := turnManager playerInTurn.
	battleManager forceAShieldReset: activePlayer.
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| activePlayer activePlayerIndex |
	positionManager stillPlaying ifFalse: [ ^ self findShipReference: positionManager winner ].

	"---Turno---"
	turnManager playNextTurn.
	activePlayer := turnManager playerInTurn.

	"---Resetea, si es necesario, los escudos luego de los dos turnos de penalizacion---"
	self checkIfRecoveryNeeded: activePlayer.

	"---Avanza con la tirada---"
	positionManager move: activePlayer with: setOfDie throw.

	"---Aplicacion de efecto---"
	"VERIFICAR EN LA BRANCH QUE FALTA, quizas meta que el check anterior"
	"me devuelva la lista de los shipshields para poder pasarsela al board, aunque"
	"capaz me convenga simplemente pasar el Game"
	playersFeature := board
		                  applyEffectTriggeredByPlayerAt: activePlayerIndex
		                  to: playersFeature.

	"---Batalla---"
	(positionManager checkSafeZone: activePlayer) ifFalse: [
		self checkIfBattle: activePlayer ].
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ positionManager stillPlaying ] whileTrue: [ self nextPlayerThrowsDice ]
]

{ #category : 'play interface' }
Game >> playerPositions [

	^ positionManager playerPositions
]

{ #category : 'testing' }
Game >> positionFeatureOf: aShip [
	"Used for testing"

	^ positionManager findShipReference: aShip
]

{ #category : 'testing' }
Game >> shieldsFeatureOf: aShip [
	"Used for testing"

	^ battleManager findShipReference: aShip
]

{ #category : 'testing' }
Game >> turnsFeatureOf: aShip [
	"Used for testing"

	^ turnManager findShipReference: aShip
]
