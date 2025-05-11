"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'players',
		'board',
		'setOfDie',
		'turn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'Creation' }
Game class >> playedBy: aSetOfPlayers onBoard: aBoard [
	^self new initializeGamePlayWithoutDice: aSetOfPlayers onBoard: aBoard.
]

{ #category : 'Creation' }
Game class >> playedBy: aSetOfPlayers onBoard: aBoard withDie: aSetOfDie [ 
	^self new initializeGamePlayedBy: aSetOfPlayers onBoard: aBoard withDie: aSetOfDie.
]

{ #category : 'initialization' }
Game >> initializeGamePlayWithoutDice: aSetOfPlayers onBoard: aBoard [
	players := aSetOfPlayers.
	board := aBoard.
	turn:=0.
]

{ #category : 'initialization' }
Game >> initializeGamePlayedBy: aSetOfPlayers onBoard: aBoard withDie: aSetOfDie [ 
	players := aSetOfPlayers.
	board := aBoard.
	setOfDie := aSetOfDie.
	turn:=0.
]

{ #category : 'as yet unclassified' }
Game >> nextTurn [	
	turn:=turn +1.
	^players at: ((turn - 1) \\ players size) +1.
]
