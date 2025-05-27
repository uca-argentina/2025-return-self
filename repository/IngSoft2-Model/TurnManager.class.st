"
A handler of the turn and game current status with the set of players.
"
Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'players',
		'turn',
		'boardLength'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TurnManager class >> with: aSetOfPlayers and: aBoardLength [
	^self new initializeSetOfPlayers: aSetOfPlayers andBoard: aBoardLength 
]

{ #category : 'unclassified' }
TurnManager >> checkifPlayerStillPlaying: player [

	^ player position < boardLength
]

{ #category : 'initialization' }
TurnManager >> initializeSetOfPlayers: aSet andBoard: aBoardLength [
	players := aSet.
	turn:=0.
	boardLength := aBoardLength 
]

{ #category : 'unclassified' }
TurnManager >> nextTurn [
	"solucion 1
	|activePlayer|
	turn := turn + 1.
	activePlayer := players at: self playerInTurn.
	activePlayer move: setOfDie with: wormhole.
	"

	"solucion 2"

	turn := turn + 1.
	^ players at: self playerInTurn
]

{ #category : 'as yet unclassified' }
TurnManager >> playTurnUsing: aSetOfDie and: aWormhole [

	| activePlayer |
	turn := turn + 1.
	activePlayer := players at: self playerInTurn.
	activePlayer := activePlayer move: aSetOfDie with: aWormhole.
	players at: self playerInTurn put: activePlayer.
	^ activePlayer
]

{ #category : 'unclassified' }
TurnManager >> playerInTurn [
	^(turn - 1 \\ players size + 1). "The players whose turn is up"
]

{ #category : 'accessing' }
TurnManager >> stillPlaying [

	^ players allSatisfy: [ :player | self checkifPlayerStillPlaying: player ]
]

{ #category : 'unclassified' }
TurnManager >> updateCurrentlyInTurn: aPlayer [
	players at: self playerInTurn put: aPlayer.
]

{ #category : 'comparing' }
TurnManager >> whoWon [

	| playerWhoWon |
	playerWhoWon := players
		                detect: [ :player |
		                (self checkifPlayerStillPlaying: player) not ]
		                ifNone: [ ^ 'NO ONE WON!' ].
	^ playerWhoWon name
]
