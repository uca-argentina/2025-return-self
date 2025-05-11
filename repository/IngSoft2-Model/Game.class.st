Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'players',
		'board',
		'setOfDie',
		'turn',
		'stillPlaying',
		'playerWhoWon',
		'wormhole'
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

{ #category : 'Creation' }
Game class >> playedBy: aSetOfPlayers onBoard: aBoard withWormhole: aWormhole [ 
	^self new initializeGamePlayedBy: aSetOfPlayers onBoard: aBoard withWormhole: aWormhole
]

{ #category : 'as yet unclassified' }
Game >> evaluateIfGameIsStillGoing [
	players do:[:player |
		(player position > board lenght) ifTrue: [ stillPlaying := false. playerWhoWon:= player. ].
		].
]

{ #category : 'initialization' }
Game >> initializeGamePlayWithoutDice: aSetOfPlayers onBoard: aBoard [
	players := aSetOfPlayers.
	board := aBoard.
	turn:=0.
	stillPlaying := true.
	wormhole:=Wormhole oneEnd:1 otherEnd:1.
]

{ #category : 'initialization' }
Game >> initializeGamePlayedBy: aSetOfPlayers onBoard: aBoard withDie: aSetOfDie [ 
	players := aSetOfPlayers.
	board := aBoard.
	setOfDie := aSetOfDie.
	turn:=0.
	stillPlaying := true.
	wormhole:=Wormhole oneEnd:1 otherEnd:1.
]

{ #category : 'initialization' }
Game >> initializeGamePlayedBy: aSetOfPlayers onBoard: aBoard withWormhole: aWormhole [
	players := aSetOfPlayers.
	board := aBoard.
	wormhole:= aWormhole.
	turn:=0.
	stillPlaying := true.
]

{ #category : 'as yet unclassified' }
Game >> nextTurn [	
	self evaluateIfGameIsStillGoing.
	self stillPlaying ifTrue:[
		|player|
		turn:=turn +1.
		player := players at: ((turn - 1) \\ players size) +1."The players whose turn is up"
		wormhole suckInIfEncounter: player.
		^player
	]
	ifFalse:[^EmptyPlayer new]."An object whose response to ~move: sarasa~ is ~Game is already over~"
	
]

{ #category : 'accessing' }
Game >> stillPlaying [
 ^stillPlaying .
]

{ #category : 'as yet unclassified' }
Game >> whoWon [
	self evaluateIfGameIsStillGoing.
	self stillPlaying 
		ifTrue:[^'Game is still on.']
		ifFalse:[^playerWhoWon name,' WON!'].
	
]
