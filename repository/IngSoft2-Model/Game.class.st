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
		'battleManager',
		'nextPlayerIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> playedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps [
	^ self new initializePlayedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps 
]

{ #category : 'as yet unclassified' }
Game >> activePlayer [

	^ players at: nextPlayerIndex
]

{ #category : 'comparing' }
Game >> checkifPlayerStillPlaying: aPlayer [

	^ aPlayer lap < numberOfLaps.
]

{ #category : 'as yet unclassified' }
Game >> findIndexOf: aPlayer [

	^ players findFirst: [ :each | each equals: aPlayer ]
]

{ #category : 'accessing' }
Game >> findPlayerAt: anIndex [

	^ players at: anIndex
]

{ #category : 'initialization' }
Game >> initializePlayedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: anAmountOfLaps [ 
	turnManager := TurnManager createWith: aGroupOfPlayers.
	battleManager := BattleManager createWith: aGroupOfPlayers.
	setOfDie := aSetOfDie.
	board := aBoard.
	numberOfLaps := anAmountOfLaps.
	players := aGroupOfPlayers.
	nextPlayerIndex := 0
]

{ #category : 'interaction loop' }
Game >> nextPlayerSkipsTurn [

	| anUpdatedPlayer |
	self stillPlaying ifFalse: [ ^ self ].
	turnManager := turnManager updateWith: players.
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
	turnManager := turnManager updateWith: players.
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

{ #category : 'as yet unclassified' }
Game >> nextPlayerThrowsDiceBanana [

	| activePlayer activePlayerIndex |
	self stillPlaying ifFalse: [ ^ self ].
	"---Turno---"
	turnManager := turnManager updateWith: players.
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

{ #category : 'as yet unclassified' }
Game >> nextPlayerTurnBegins [

nextPlayerIndex := (nextPlayerIndex) \\ (players size) + 1
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ self stillPlaying ] whileTrue: [ self nextPlayerThrowsDice ]
]

{ #category : 'interaction loop' }
Game >> playerPositions [
|aListOfPositions|
	aListOfPositions := players collect:[:player | player name , ' : ', 
		player position asString, ' , lap: ',
		player lap asString].
	^aListOfPositions
]

{ #category : 'accessing' }
Game >> stillPlaying [

	^ players allSatisfy: [ :player |
		  self checkifPlayerStillPlaying: player ]
]

{ #category : 'as yet unclassified' }
Game >> updateWithModified: aPlayer [

	| anIndex |
	anIndex := players findFirst: [ :each | each name = aPlayer name ].
	players at: anIndex put: aPlayer
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
