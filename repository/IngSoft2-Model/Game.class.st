"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'setOfDie',
		'wormhole',
		'playersTurn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Game class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'creation' }
Game class >> playedBy: aSetOfPlayers withBoardLength: aBoardLength withEffect: aWormhole withSetOfDie: aDieSet [

	| aXSetOfPlayers |
	self boardLengthMustBeGreaterThanThree: aBoardLength.
	"self wormhole: aWormhole shouldBeInside: aBoardLength."

	aXSetOfPlayers := aSetOfPlayers.
	aXSetOfPlayers isArray ifFalse: [
		aXSetOfPlayers := { aXSetOfPlayers } ].
	^ self new
		  initializeGamePlay: aXSetOfPlayers
		  withBoardLength: aBoardLength
		  withEffect: aWormhole
		  withSetOfDie: aDieSet
]

{ #category : 'creation' }
Game class >> playedBy: aSetOfPlayers withBoardLength: aBoardLength withEffect: aWormhole withSetOfDie: aDieSet withLaps: numberOfLaps [

	| aXSetOfPlayers |
	self boardLengthMustBeGreaterThanThree: aBoardLength.
	"self wormhole: aWormhole shouldBeInside: aBoardLength."

	aXSetOfPlayers := aSetOfPlayers.
	aXSetOfPlayers isArray ifFalse: [
		aXSetOfPlayers := { aXSetOfPlayers } ].
	^ self new
		  initializeGamePlay: aXSetOfPlayers
		  withBoardLength: aBoardLength
		  withEffect: aWormhole
		  withSetOfDie: aDieSet
		  withLaps: numberOfLaps 
]

{ #category : 'testing' }
Game class >> wormhole: aWormhole shouldBeInside: aLength [

	(aWormhole areEndsInside: aLength) ifFalse: [
		Error signal: 'Both wormhole ends must be within the board length.' ]
]

{ #category : 'initialization' }
Game >> initializeGamePlay: aXSetOfPlayers withBoardLength: aBoardLength withEffect: aWormhole withSetOfDie: aSetOfDie [

	playersTurn := TurnManager with: aXSetOfPlayers and: aBoardLength.
	wormhole := aWormhole.
	setOfDie := aSetOfDie
]

{ #category : 'initialization' }
Game >> initializeGamePlay: aXSetOfPlayers withBoardLength: aBoardLength withEffect: aWormhole withSetOfDie: aSetOfDie withLaps: numberOfLaps [

	playersTurn := TurnManager with: aXSetOfPlayers and: aBoardLength and: numberOfLaps .
	wormhole := aWormhole.
	setOfDie := aSetOfDie
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| anUpdatedPlayer |
	playersTurn stillPlaying ifFalse: [ ^ self ].
	anUpdatedPlayer := playersTurn
		                   playTurnUsing: setOfDie throw
		                   and: wormhole.
	^ anUpdatedPlayer position
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ playersTurn stillPlaying ] whileTrue: [ self nextPlayerThrowsDice ]
]

{ #category : 'comparing' }
Game >> winner [

	^ playersTurn winner
]
