"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'setOfDie',
		'playersTurn',
		'battle',
		'effect',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Game class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'as yet unclassified' }
Game class >> playedBy: aSetOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps [
	"self boardLengthMustBeGreaterThanThree: aBoard totalTiles."
	^ self new initializePlayedBy: aSetOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps 
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
Game >> initializeGamePlay: aXSetOfPlayers withBoardLength: aBoardLength withEffect: anEffect withSetOfDie: aSetOfDie [

	playersTurn := EffectApplicationManager with: aXSetOfPlayers and: aBoardLength.
	battle := BattleManager new.
	effect := anEffect .
	setOfDie := aSetOfDie
]

{ #category : 'initialization' }
Game >> initializeGamePlay: aXSetOfPlayers withBoardLength: aBoardLength withEffect: aWormhole withSetOfDie: aSetOfDie withLaps: numberOfLaps [

	playersTurn := EffectApplicationManager with: aXSetOfPlayers and: aBoardLength and: numberOfLaps .
	battle := BattleManager new.
	effect := aWormhole.
	setOfDie := aSetOfDie
]

{ #category : 'initialization' }
Game >> initializePlayedBy: aSetOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps [ 
	playersTurn := EffectApplicationManager with: aSetOfPlayers and: aBoard totalTiles and: laps .
	battle := BattleManager new.
	setOfDie := aSetOfDie.
	board := aBoard
]

{ #category : 'interaction loop' }
Game >> nextPlayerSkipsTurn [

	| anUpdatedPlayer |
	playersTurn stillPlaying ifFalse: [ ^ self ].
	anUpdatedPlayer := playersTurn skipTurn.
		                   "playTurnUsing: setOfDie throw
		                   and: wormhole."
	"-----Batalla-----"
	"playersTurn setOfPlayers: (battle engagePlayer: anUpdatedPlayer 
												withDice: setOfDie 
												against: (playersTurn setOfPlayers)) .
	anUpdatedPlayer := playersTurn setOfPlayers at:(playersTurn playerInTurnIndex)."

	^ anUpdatedPlayer position
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| anUpdatedPlayer |
	playersTurn stillPlaying ifFalse: [ ^ self ].
	anUpdatedPlayer := playersTurn
		                   playTurnUsing: setOfDie throw
		                   and: board.
	"-----Batalla-----"
	playersTurn setOfPlayers: (battle engagePlayer: anUpdatedPlayer 
												withDice: setOfDie 
												against: (playersTurn setOfPlayers)) .
	anUpdatedPlayer := playersTurn setOfPlayers at:(playersTurn playerInTurnIndex).

	^ anUpdatedPlayer position
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ playersTurn stillPlaying ] whileTrue: [ self nextPlayerThrowsDice ]
]

{ #category : 'interaction loop' }
Game >> playerPositions [

	^ playersTurn setOfPlayers collect:[:player | player name , ' : ', 
		player position asString, ' , lap: ',
		player lap asString, 
		', shields: ',player shields asString]
]

{ #category : 'interaction loop' }
Game >> playersInPosition: aPosition [

	^ playersTurn setOfPlayers select:[:player | player position = aPosition ]
]

{ #category : 'comparing' }
Game >> winner [

	^ playersTurn winner
]
