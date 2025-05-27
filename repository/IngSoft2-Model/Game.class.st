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

	players := TurnManager with:aXSetOfPlayers and: aBoardLength.
	wormhole := aWormhole.
	setOfDie := aSetOfDie.
	
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [
	
	| anUpdatedPlayer |
	players stillPlaying ifTrue: [
			anUpdatedPlayer := players nextTurn move: setOfDie with: wormhole.
			players updateCurrentlyInTurn: anUpdatedPlayer.
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
