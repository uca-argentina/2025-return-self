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

	^ self new
		  initializeGamePlay: aSetOfPlayers
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
Game >> nextPlayerThrowsDice: dice [
	self evaluateIfGameIsStillGoing.
	self stillPlaying ifTrue: [
			| player |
			turn := turn + 1.
			player := self playerWhoseTurnIsNow.
			^ board movePlayer: player thisManySteps:(dice throw).
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
Game >> playerWhoseTurnIsNow [
	^players at: (turn - 1 \\ players size + 1). "The players whose turn is up"
]

{ #category : 'accessing' }
Game >> stillPlaying [

	^ stillPlaying
]

{ #category : 'as yet unclassified' }
Game >> whoWon [

	self evaluateIfGameIsStillGoing.
	self stillPlaying
		ifTrue: [ ^ 'Game is still on.' ]
		ifFalse: [ ^ playerWhoWon name , ' WON!' ]
]
