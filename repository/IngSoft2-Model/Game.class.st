"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'setOfDie',
		'effect',
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
Game class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'as yet unclassified' }
Game class >> playedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps [
	self boardLengthMustBeGreaterThanThree: aBoard totalTiles.
	^ self new initializePlayedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps 
]

{ #category : 'testing' }
Game class >> wormhole: aWormhole shouldBeInside: aLength [

	(aWormhole areEndsInside: aLength) ifFalse: [
		Error signal: 'Both wormhole ends must be within the board length.' ]
]

{ #category : 'comparing' }
Game >> checkifPlayerStillPlaying: aPlayer [

	^ aPlayer lap < numberOfLaps.
]

{ #category : 'as yet unclassified' }
Game >> findIndexOf: aPlayer [

	^ players findFirst: [ :each | each name = aPlayer name ]
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

	| anUpdatedPlayer |
	self stillPlaying ifFalse: [ ^ self ].
	turnManager := turnManager updateWith: players and: turnManager turnsThatPassed.
	anUpdatedPlayer := turnManager skipTurn.
		                   "playTurnUsing: setOfDie throw
		                   and: wormhole."
	"-----Batalla-----"
	"playersTurn setOfPlayers: (battle engagePlayer: anUpdatedPlayer 
												withDice: setOfDie 
												against: (playersTurn setOfPlayers)) .
	anUpdatedPlayer := playersTurn setOfPlayers at:(playersTurn playerInTurnIndex)."

	^ anUpdatedPlayer position
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| activePlayer activePlayerIndex |
	self stillPlaying ifFalse: [ ^ self ].
	"---Turno---"
	turnManager := turnManager updateWith: players and: turnManager turnsThatPassed.
	activePlayer := turnManager nextTurnPlayer.
	activePlayerIndex := self findIndexOf: activePlayer.
	
	"---Avanza con la tirada---"
	activePlayer := activePlayer advanceTiles: setOfDie throw.
	activePlayer := activePlayer circleAroundTheTrackWithLength: board totalTiles.
	
	"---Aplicacion de efecto---"
	players at: activePlayerIndex put: activePlayer.
	players := board applyEffectTriggeredByPlayerAt: activePlayerIndex to: players.
	
	"---Batalla---"
	battleManager := battleManager updateWith: players.
	activePlayer := players at: activePlayerIndex.
	players := battleManager ifBattleThenEngage: activePlayer using: setOfDie.
	
	activePlayer := players at: activePlayerIndex.
	^ activePlayer position
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ turnManager stillPlaying ] whileTrue: [ self nextPlayerThrowsDice ]
]

{ #category : 'interaction loop' }
Game >> playerPositions [

	^ turnManager setOfPlayers collect:[:player | player name , ' : ', 
		player position asString, ' , lap: ',
		player lap asString, 
		', shields: ',player shields asString]
]

{ #category : 'interaction loop' }
Game >> playersInPosition: aPosition [

	^ turnManager setOfPlayers select:[:player | player position = aPosition ]
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
		                ifNone: [ ^ 'NO ONE WON!' ].
	^ playerWhoWon name
]
