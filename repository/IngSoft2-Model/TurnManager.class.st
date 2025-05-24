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

{ #category : 'unclassified' }
TurnManager >> currentlyInTurn [
   ^(players at: self playerInTurn)
]

{ #category : 'initialization' }
TurnManager >> initializeSetOfPlayers: aSet andBoard: aBoardLength [
	players := aSet.
	turn:=0.
	boardLength := aBoardLength 
]

{ #category : 'unclassified' }
TurnManager >> nextTurn [ 
turn:= turn +1
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
