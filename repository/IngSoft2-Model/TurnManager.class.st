Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'turn',
		'players'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
TurnManager class >> createWith: aGroupOfPlayers [

	^self new initializePlayers: aGroupOfPlayers and: 0
]

{ #category : 'as yet unclassified' }
TurnManager class >> updateWith: aGroupOfPlayers and: aNumberOfTurns [

^self new initializePlayers: aGroupOfPlayers and: aNumberOfTurns
]

{ #category : 'initialization' }
TurnManager >> initializePlayers: aGroup and: turnsPassed [

	players := aGroup.
	turn := turnsPassed
]

{ #category : 'as yet unclassified' }
TurnManager >> nextTurnPlayer [
	| activePlayer |
	turn := turn + 1.
	activePlayer := players at: self playerInTurnIndex.
	
	"VER"
	[activePlayer skipATurn] whileTrue: [
		players at: self playerInTurnIndex put:(activePlayer turnSkipped ).
		turn := turn + 1.
		activePlayer := players at: self playerInTurnIndex.
		].
	
	activePlayer:= activePlayer resetShieldsAfter2TurnsWithout.
	players at: self playerInTurnIndex put: activePlayer.
	^ activePlayer
]

{ #category : 'play interface' }
TurnManager >> playerInTurnIndex [

	^ turn - 1 \\ players size + 1 "The players whose turn is up"
]

{ #category : 'play interface' }
TurnManager >> skipTurn [
	| activePlayer |
	turn := turn + 1.
	activePlayer := players at: self playerInTurnIndex.
	activePlayer:= activePlayer forceAShieldReset.
	
	players at: self playerInTurnIndex put: activePlayer.
	^ activePlayer
]

{ #category : 'as yet unclassified' }
TurnManager >> turnsThatPassed [
^turn
]
