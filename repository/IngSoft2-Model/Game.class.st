"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'setOfDie',
		'board',
		'numberOfLaps',
		'players',
		'turnManager',
		'battleManager'
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

{ #category : 'as yet unclassified' }
Game >> activePlayerIndex [

	| aPlayer |
	aPlayer := turnManager playerInTurn.
	^ players findFirst: [ :each | each equals: aPlayer ]
]

{ #category : 'as yet unclassified' }
Game >> checkIfRecoveryNeeded: aPlayer [

	turnManager checkNoTurnsToSkip ifTrue: [ battleManager resetShieldsAfter2Turns: aPlayer ]
]

{ #category : 'comparing' }
Game >> checkifPlayerStillPlaying: aPlayer [

	^ aPlayer lap < numberOfLaps.
]

{ #category : 'initialization' }
Game >> initializePlayedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: anAmountOfLaps [

	turnManager := TurnManager createWith: aGroupOfPlayers.
	battleManager := BattleManager createWith: aGroupOfPlayers.
	setOfDie := aSetOfDie.
	board := aBoard.
	numberOfLaps := anAmountOfLaps.
	players := aGroupOfPlayers
]

{ #category : 'interaction loop' }
Game >> nextPlayerSkipsTurn [

	| activePlayer activePlayerIndex |
	self stillPlaying ifFalse: [ ^ self ].
	turnManager skipTurn.
	activePlayerIndex := self activePlayerIndex.
	activePlayer := players at: activePlayerIndex.
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
	self stillPlaying ifFalse: [ ^ self ].
	
	"---Turno---"
	activePlayerIndex := self activePlayerIndex: turnManager playNextTurn.
	activePlayer := players at: activePlayerIndex.
	
	"---Resetea, si es necesario, los escudos luego de los dos turnos de penalizacion---"
	self checkIfRecoveryNeeded: activePlayer.
	
	"---Avanza con la tirada---"
	activePlayer := activePlayer advanceTiles: setOfDie throw.
	activePlayer := activePlayer circleAroundTheTrackWithLength: board totalTiles.
	players at: activePlayerIndex put: activePlayer.
	
	"---Aplicacion de efecto---"
	"VERIFICAR EN LA BRANCH QUE FALTA, quizas meta que el check anterior"
	"me devuelva la lista de los shipshields para poder pasarsela al board, aunque"
	"capaz me convenga simplemente pasar el Game"
	players := board applyEffectTriggeredByPlayerAt: activePlayerIndex to: players.
	
	"---Batalla---"
	"battleManager := battleManager updateWith: players."
	players := battleManager ifBattleThenEngage: activePlayer using: setOfDie.
	
	activePlayer := players at: activePlayerIndex.
	
	^ activePlayer position
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ self stillPlaying ] whileTrue: [ self nextPlayerThrowsDice ]
]

{ #category : 'interaction loop' }
Game >> playerPositions [

	| aListOfPositions |
	aListOfPositions := players collect: [ :player |
		                    'Name: ' , player name , ' , Position: '
		                    , player position asString , ' , Lap: '
		                    , player lap asString ].
	^ aListOfPositions
]

{ #category : 'accessing' }
Game >> stillPlaying [

	^ players allSatisfy: [ :player |
		  self checkifPlayerStillPlaying: player ]
]

{ #category : 'comparing' }
Game >> winner [

	| playerWhoWon |
	playerWhoWon := players
		                detect: [ :player |
		                (self checkifPlayerStillPlaying: player) not ]
		                ifNone: [ ^ nil ].
	^ playerWhoWon name
]
