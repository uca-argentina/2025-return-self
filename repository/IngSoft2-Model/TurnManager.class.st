Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'players',
		'turn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TurnManager class >> with: aSetOfPlayers [
	^self new initializeSetOfPlayers: aSetOfPlayers
]

{ #category : 'initialization' }
TurnManager >> calculateIfstillPlayingWithBoardLength: boardLenght [

	players do: [ :player | player position > boardLenght ifTrue: [ ^ player] ].
	^ NotAplayer new.
]

{ #category : 'initialization' }
TurnManager >> currentlyInTurn [
   ^(players at: self playerInTurn)
]

{ #category : 'initialization' }
TurnManager >> initializeSetOfPlayers: aSet [
	players := aSet.
	turn:=0
]

{ #category : 'initialization' }
TurnManager >> nextTurn [ 
turn:= turn +1
]

{ #category : 'initialization' }
TurnManager >> playerInTurn [
	^(turn - 1 \\ players size + 1). "The players whose turn is up"
]

{ #category : 'initialization' }
TurnManager >> updateCurrentlyInTurn: aPlayer [
	players at: self playerInTurn put: aPlayer.
]
