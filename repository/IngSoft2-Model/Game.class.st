Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'players',
		'board',
		'setOfDie'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'Creation' }
Game class >> playedBy: aSetOfPlayers onBoard: aBoard withDie: aSetOfDie [ 
	^self new initializeGamePlayedBy: aSetOfPlayers onBoard: aBoard withDie: aSetOfDie.
]

{ #category : 'initialization' }
Game >> initializeGamePlayedBy: aSetOfPlayers onBoard: aBoard withDie: aSetOfDie [ 
	players := aSetOfPlayers.
	board := aBoard.
	setOfDie := aSetOfDie.
]
