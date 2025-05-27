"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'players',
		'setOfDie',
		'wormhole'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Game class >> playedBy: aSetOfPlayers withBoardLength: aBoardLength withWormhole: aWormhole withSetOfDie: aDieSet [ 
	
	| aXSetOfPlayers |
	
	self wormhole: aWormhole shouldBeInside: aBoardLength.
	
	aXSetOfPlayers:=aSetOfPlayers.
	(aXSetOfPlayers isArray ) ifFalse:[aXSetOfPlayers := {aXSetOfPlayers}].
	^ self new
		  initializeGamePlay: aXSetOfPlayers
		  withBoardLength: aBoardLength
		 withWormhole: aWormhole
		  withSetOfDie: aDieSet
]

{ #category : 'testing' }
Game class >> wormhole: aWormhole shouldBeInside: aLength [

	(aWormhole areEndsInside: aLength) ifFalse: [
		Error signal: 'Both wormhole ends must be within the board length.' ]
]

{ #category : 'initialization' }
Game >> initializeGamePlay: aXSetOfPlayers withBoardLength: aBoardLength 
withWormhole: aWormhole withSetOfDie: aSetOfDie [

	players := TurnManager with:aXSetOfPlayers and: aBoardLength.
	wormhole := aWormhole.
	setOfDie := aSetOfDie.
	
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [
	
	| anUpdatedPlayer |
	players stillPlaying ifTrue: [
			anUpdatedPlayer := players playTurnUsing: setOfDie and: wormhole.
			^ anUpdatedPlayer position.
		].
		^ 'Game is already over.'
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[players stillPlaying ] whileTrue: [
		self nextPlayerThrowsDice ]
]

{ #category : 'comparing' }
Game >> whoWon [
	^ players whoWon.
]
