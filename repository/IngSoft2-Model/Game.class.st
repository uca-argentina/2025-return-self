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

	(aNumberOfLaps > 0 and: aNumberOfLaps isInteger) ifFalse: [
		Error signal:
			'The amount of laps cannot be lower than 1 or a float number.' ]
]

{ #category : 'creation' }
Game class >> playedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps [

	self lapHasToBeGreaterThanZeroAndInteger: laps.
	self twoPlayersCantHaveTheSameId: aGroupOfPlayers.
	^ self new
		  initializePlayedBy: aGroupOfPlayers
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

{ #category : 'NEEDCORRECTION' }
Game >> nextPlayerSkipsTurn [

	| activePlayer activePlayerIndex |
	positionManager stillPlaying ifFalse: [ ^ self winner ].
	turnManager skipTurn.
	activePlayerIndex := self findPlayerIndex: turnManager playerInTurn.
	activePlayer := playersFeature at: activePlayerIndex.
	battleManager forceAShieldReset: activePlayer.
	"-----Batalla-----"
	"playersTurn setOfPlayers: (battle engagePlayer: anUpdatedPlayer 
												withDice: setOfDie 
												against: (playersTurn setOfPlayers)) .
	anUpdatedPlayer := playersTurn setOfPlayers at:(playersTurn playerInTurnIndex)."

	^ activePlayer position
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| activePlayer activePlayerIndex |
	positionManager stillPlaying ifFalse: [ ^ self winner ].

	"---Turno---"
	turnManager playNextTurn.
	activePlayerIndex := self findPlayerIndex: turnManager playerInTurn.
	activePlayer := playersFeature at: activePlayerIndex.

	"---Resetea, si es necesario, los escudos luego de los dos turnos de penalizacion---"
	self checkIfRecoveryNeeded: activePlayer.

	"---Avanza con la tirada---"
	"
	ESTO VA A PASAR A ENCARGARSE EL POSITION MANAGER"
	positionManager move: activePlayer with: setOfDie throw.

	"---Aplicacion de efecto---"
	"VERIFICAR EN LA BRANCH QUE FALTA, quizas meta que el check anterior"
	"me devuelva la lista de los shipshields para poder pasarsela al board, aunque"
	"capaz me convenga simplemente pasar el Game"
	playersFeature := board
		                  applyEffectTriggeredByPlayerAt: activePlayerIndex
		                  to: playersFeature.

	"---Batalla---"
	"battleManager := battleManager updateWith: players."
	(positionManager checkSafeZone: activePlayer) ifFalse: [
		self updateAfterBattle: activePlayer ].


	^ activePlayer position
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ positionManager stillPlaying ] whileTrue: [ self nextPlayerThrowsDice ]
]

{ #category : 'NEEDCORRECTION' }
Game >> playerPositions [

	| aListOfPositions |
	aListOfPositions := playersFeature collect: [ :player |
		                    'Name: ' , player name , ' , Position: '
		                    , player position asString , ' , Lap: '
		                    , player lap asString ].
	^ aListOfPositions
]

{ #category : 'NEEDCORRECTION' }
Game >> updateAfterBattle: activePlayer [

	| playersToEngage playerWhoLost playerIndex |
	playersToEngage := playersFeature select: [ :each |
		                   each samePositionAs: activePlayer ].
	playersToEngage = 2 ifFalse: [ ^ self ].
	playerWhoLost := battleManager
		                 ifBattleThenEngage: playersToEngage
		                 using: setOfDie.
	playerWhoLost needsRecovery ifTrue: [
		turnManager addTwoSkipsTo: playerWhoLost ].
	playerIndex := self findPlayerIndex: playerWhoLost.
	playerWhoLost := playersFeature at: playerIndex.
	playersFeature at: playerIndex put: playerWhoLost goToFirstTile
]

{ #category : 'play interface' }
Game >> winner [

	| playerIndex |
	playerIndex := self findPlayerIndex: positionManager winner.
	^ (playersFeature at: playerIndex) name
]
