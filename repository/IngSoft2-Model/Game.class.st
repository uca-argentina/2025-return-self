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
		'turn',
		'stillPlaying',
		'playerWhoWon'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> playedBy: aSetOfPlayers onBoard: aBoard withSetOfDie: aDieSet [
	
	| aXSetOfPlayers |
	aXSetOfPlayers:=aSetOfPlayers.
	(aXSetOfPlayers isArray ) ifFalse:[aXSetOfPlayers := {aXSetOfPlayers}].
	^ self new
		  initializeGamePlay: aXSetOfPlayers
		  onBoard: aBoard
		  withSetOfDie: aDieSet
]

{ #category : 'comparing' }
Game >> evaluateIfGameIsStillGoing [

	players do: [ :player |
		player position > board lenght ifTrue: [
			stillPlaying := false.
			playerWhoWon := player ] ]
]

{ #category : 'initialization' }
Game >> initializeGamePlay: aSetOfPlayers onBoard: aBoard withSetOfDie: aSetOfDie [
	players := aSetOfPlayers.
	board := aBoard.
	turn:=0.
	stillPlaying := true.
	setOfDie := aSetOfDie.
	playerWhoWon := 'NO ONE'.
]

{ #category : 'as yet unclassified' }
Game >> movePlayer: aPlayer distance: aDistance [ 
	| newDistance anUpdatedPlayer|
	newDistance:= aPlayer position + aDistance.
	anUpdatedPlayer := Player named: (aPlayer name) withPosition: newDistance.
	anUpdatedPlayer := (board checkEffects: newDistance) applyEffectOn: anUpdatedPlayer.
	
	self updatePlayerInTurnStatus: anUpdatedPlayer.
	^anUpdatedPlayer .
	
]

{ #category : 'as yet unclassified' }
Game >> nextPlayerThrowsDice: aDice [
	self evaluateIfGameIsStillGoing.
	self stillPlaying ifTrue: [
			| aPlayer |
			turn := turn + 1.
			aPlayer := self playerInTurn.
			aPlayer := self movePlayer: aPlayer distance: aDice throw .
			
			^ aPlayer position.
		].
		^ 'Game is already over.'
]

{ #category : 'as yet unclassified' }
Game >> playFullGame [

	self evaluateIfGameIsStillGoing.
	[ stillPlaying ] whileTrue: [
		self evaluateIfGameIsStillGoing.
		self nextPlayerThrowsDice: setOfDie ]
]

{ #category : 'as yet unclassified' }
Game >> playerInTurn [
	^players at: (turn - 1 \\ players size + 1). "The players whose turn is up"
]

{ #category : 'accessing' }
Game >> stillPlaying [

	^ stillPlaying
]

{ #category : 'as yet unclassified' }
Game >> updatePlayerInTurnStatus: aPlayer [
	players at: (turn - 1 \\ players size + 1) put: aPlayer . "The players whose turn is up"
	
]

{ #category : 'as yet unclassified' }
Game >> whoWon [

	self evaluateIfGameIsStillGoing.
	self stillPlaying
		ifTrue: [ ^ 'Game is still on.' ]
		ifFalse: [ ^ playerWhoWon name , ' WON!' ]
]
