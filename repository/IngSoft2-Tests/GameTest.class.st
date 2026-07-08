Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#instVars : [
		'aShipListTemplate'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'queries - testing' }
GameTest >> playFullGameIn: aGame [

	[aGame stillPlaying ] whileTrue: [ aGame nextPlayerPlays ]
]

{ #category : 'queries - testing' }
GameTest >> playFullRoundIn: aGame and: anAmountOfPlayers [

	1 to: anAmountOfPlayers do: [ :turn | aGame nextPlayerPlays ]
]

{ #category : 'running' }
GameTest >> setUp [

	| aListOfNames |
	super setUp.

	aListOfNames := { 'Pato'. 'Mati' }.
	"To avoid repeated IDs"
	aShipListTemplate := (1 to: aListOfNames size) collect: [ :id |
		                       Ship createWith: id ]
]

{ #category : 'tests' }
GameTest >> test010WhenThePlayerThrowsItsShipMovesForward [

	| aGame aDie aGoalMark aShip |
	"aShipName := 'Pato'. DEPRECATED
	aListOfNames := { 'Pato'. 'Mati' }. DEPRECATED"
	aGoalMark := 12.
	aDie := LoadedDie createWith: 6.
	aGame := Game createWith: aShipListTemplate and: aDie and: aGoalMark.

	aGame nextPlayerPlays.

	aShip := aShipListTemplate at: 1.

	self assert: (aGame ship: aShip isIn: 7)
]

{ #category : 'tests' }
GameTest >> test011WhenThePlayersShipIsInTheGoalMarkOrGreaterThenItWins [

	| aGame aDie aGoalMark aShip |
	"aPlayerName := 'Pato'. DEPRECATED
	aListOfNames := { 'Pato'. 'Mati' }. DEPRECATED"
	aGoalMark := 7.
	aDie := LoadedDie createWith: 6.
	aGame := Game
		         createWith: aShipListTemplate
		         and: aDie
		         and: aGoalMark.

	aGame nextPlayerPlays.

	aShip := aShipListTemplate at: 1.

	self assert: (aGame isWinner: aShip)
]

{ #category : 'tests' }
GameTest >> test012WhenTheGameIsPlayedAFullRoundAllPlayersShipsMoved [

	| aGame aDie aGoalMark shipOne shipTwo |
	"aListOfNames := { 'Pato'. 'Mati' }. DEPRECATED"
	aGoalMark := 12.
	aDie := LoadedDie createWith: 6.
	aGame := Game createWith: aShipListTemplate and: aDie and: aGoalMark.

	self playFullRoundIn: aGame and: aShipListTemplate size.

	"aShip := (aGame returnPlayerWithId: 1) ship.
	anotherShip := (aGame returnPlayerWithId: 2) ship. DEPRECATED"

	shipOne := aShipListTemplate at: 1.
	shipTwo := aShipListTemplate at: 2.

	self assert: (aGame ship: shipOne isIn: 7).
	self assert: (aGame ship: shipTwo isIn: 7)
]

{ #category : 'tests' }
GameTest >> test013WhenTheGameIsPlayedUntilIsFinishedTheresAWinner [

	| aGame aDie aGoalMark aShip |
	"aListOfNames := { 'Pato'. 'Mati' }. DEPRECATED"
	aGoalMark := 12.
	aDie := LoadedDie createWith: 6.
	aGame := Game createWith: aShipListTemplate and: aDie and: aGoalMark.

	self playFullGameIn: aGame.

	aShip := aShipListTemplate at: 1.

	self assert: (aGame isWinner: aShip)
]

{ #category : 'tests' }
GameTest >> test014WhenTryingToAskPositionOfANotPlayingPersonItRaisesError [

	| aGame aDie aGoalMark aShip |
	aGoalMark := 12.
	aDie := LoadedDie createWith: 6.
	aGame := Game createWith: aShipListTemplate and: aDie and: aGoalMark.

	aShip := Ship createWith: 3.

	TestUtils
		should: [ aGame ship: aShip isIn: 7 ]
		raiseWith: 'There is no ship with ID: 3.'
]

{ #category : 'tests' }
GameTest >> test018WhenThePlayerThrowsItsShipMovesForwardWithMoreThanOneDie [

	| aGame dice aGoalMark aShip |
	"aShipName := 'Pato'. DEPRECATED
	aListOfNames := { 'Pato'. 'Mati' }. DEPRECATED"
	aGoalMark := 12.
	dice := Dice createWith: {
			        (LoadedDie createWith: 6).
			        (LoadedDie createWith: 2) }.
	aGame := Game createWith: aShipListTemplate and: dice and: aGoalMark.

	aGame nextPlayerPlays.

	aShip := aShipListTemplate at: 1.

	self assert: (aGame ship: aShip isIn: 9)
]
