"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'players',
		'setOfDie',
		'turn',
		'playerWhoWon',
		'wormhole',
		'boardLenght'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Game class >> playedBy: aSetOfPlayers onBoard: aBoard withSetOfDie: aDieSet [
	
	| aXSetOfPlayers |
	aXSetOfPlayers:=aSetOfPlayers.
	(aXSetOfPlayers isArray ) ifFalse:[aXSetOfPlayers := {aXSetOfPlayers}].
	^ self new
		  initializeGamePlay: aXSetOfPlayers
		  onBoard: aBoard
		  withSetOfDie: aDieSet
]

{ #category : 'creation' }
Game class >> playedBy: aSetOfPlayers withBoardLength: boardLength withWormhole: wormhole withSetOfDie: aDieSet [ 
	
	| aXSetOfPlayers |
	aXSetOfPlayers:=aSetOfPlayers.
	(aXSetOfPlayers isArray ) ifFalse:[aXSetOfPlayers := {aXSetOfPlayers}].
	^ self new
		  initializeGamePlay: aXSetOfPlayers
		  withBoardLength: boardLength
		 withWormhole: wormhole
		  withSetOfDie: aDieSet
]

{ #category : 'initialization' }
Game >> initializeGamePlay: aXSetOfPlayers withBoardLength: aBoardLength 
withWormhole: aWormhole withSetOfDie: aSetOfDie [

	players := aXSetOfPlayers.
	boardLenght := aBoardLength.
	wormhole := aWormhole.
	turn:=0.
	setOfDie := aSetOfDie.
	playerWhoWon := 'NO ONE'.
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [
	self stillPlaying ifTrue: [
			| aPlayer |
			turn := turn + 1.
			aPlayer := (players at: self playerInTurn) move: setOfDie with: wormhole.
			players at: self playerInTurn put: aPlayer.
			^ aPlayer position.
		].
		^ 'Game is already over.'
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[self stillPlaying ] whileTrue: [
		self nextPlayerThrowsDice ]
]

{ #category : 'accessing' }
Game >> playerInTurn [
	^(turn - 1 \\ players size + 1). "The players whose turn is up"
]

{ #category : 'accessing' }
Game >> stillPlaying [

	players do: [ :player |
		player position > boardLenght ifTrue: [
			playerWhoWon := player.
			^ false ] ].
	^ true
]

{ #category : 'comparing' }
Game >> whoWon [

	self stillPlaying
		ifTrue: [ ^ 'Game is still on.' ]
		ifFalse: [ ^ playerWhoWon name , ' WON!' ]
]
