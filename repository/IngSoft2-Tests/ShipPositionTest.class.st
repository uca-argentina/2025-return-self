Class {
	#name : 'ShipPositionTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipPositionTest >> test001WhenTellingAShipToAdvanceADistanceThenItReturnsANewShipWithNewPosition [

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 1 and: 0.
	anUpdatedShipPosition := aShipPosition advanceTiles: 10.

	self assert: anUpdatedShipPosition position equals: 11.
	self deny: aShipPosition position equals: 11 "Here you can be sure that original object is not affected"
]

{ #category : 'tests' }
ShipPositionTest >> test002WhenTellingAShipToGoBackADistanceThenItReturnsANewShipWithNewPosition [

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 11 and: 0.
	anUpdatedShipPosition := aShipPosition goBackTiles: 10.

	self assert: anUpdatedShipPosition position equals: 1.
	self deny: aShipPosition position equals: 1 "Here you can be sure that original object is not affected"
]

{ #category : 'tests' }
ShipPositionTest >> test003WhenAShipGoesBackADistanceGreaterThanItsPositionThenItReturnsAShipInFirstTileSameLap [

	"We assumed ships cant lose laps"

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 5 and: 2.
	anUpdatedShipPosition := aShipPosition goBackTiles: 10.

	self assert: anUpdatedShipPosition position equals: 1.
	self assert: anUpdatedShipPosition lap equals: 2
]

{ #category : 'tests' }
ShipPositionTest >> test004WhenAShipIsToldToResetLapThenItReturnsToFirstTileSameLap [

	"We assumed ships cant lose laps"

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 15 and: 2.
	anUpdatedShipPosition := aShipPosition goToFirstTile.

	self assert: anUpdatedShipPosition position equals: 1.
	self assert: anUpdatedShipPosition lap equals: 2
]

{ #category : 'tests' }
ShipPositionTest >> test005WhenShipIsInFirstTileThenItIsInSafeZone [

	| aShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 1 and: 0.

	self assert: aShipPosition inSafeZone
]

{ #category : 'tests' }
ShipPositionTest >> test006WhenShipIsNotInFirstTileThenItIsNotInSafeZone [

	| aShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 4 and: 0.

	self deny: aShipPosition inSafeZone
]

{ #category : 'tests' }
ShipPositionTest >> test007AShipKnowsToAnswerIfItsPositionIsGreaterThanAValue [

	| aShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 4 and: 0.

	self deny: (aShipPosition positionGreaterThan: 5).
	self assert: (aShipPosition positionGreaterThan: 2)
]

{ #category : 'tests' }
ShipPositionTest >> test008AShipKnowsToAnswerIfItsLapIsGreaterOrEqualThanAValue [

	| aShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 5 and: 1.

	self deny: (aShipPosition lapGreaterOrEqualThan: 2).
	self assert: (aShipPosition lapGreaterOrEqualThan: 1)
]

{ #category : 'tests' }
ShipPositionTest >> test009WhenTwoShipsAreInSamePositionThenTheyAreAware [

	| aShipPosition anotherShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 5 and: 1.
	anotherShipPosition := ShipPosition createWith: 1 and: 5 and: 2.

	self assert: (aShipPosition samePositionAs: anotherShipPosition)
]

{ #category : 'tests' }
ShipPositionTest >> test010WhenAShipSurpassesTheBoardLengthThenItStartsANewLapWithCalculatedPosition [

	"Simulating a new lap reached, the board length is also the backtrack decreased
from its overshot position"

	| aShipPosition aBoardLength aDistance anUpdatedShipPosition |
	aBoardLength := 20.
	aDistance := 10.
	aShipPosition := ShipPosition createWith: 1 and: 15 and: 1.
	anUpdatedShipPosition := aShipPosition advanceTiles: aDistance.
	anUpdatedShipPosition := anUpdatedShipPosition
		changeLapAndCorrectPositionWith:
		aBoardLength.

	self assert: anUpdatedShipPosition lap equals: 2.
	self assert: anUpdatedShipPosition position equals: 5
]

{ #category : 'tests' }
ShipPositionTest >> test011WhenTryingToCreateASpaceShipWithNegativePositionThenItThrowsError [

	self
		should: [ ShipPosition createWith: 1 and: -10 and: 0 ]
		raiseErrorWithMessageText:
		'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
ShipPositionTest >> test012WhenTryingToCreateASpaceShipWithNegativeLapThenItThrowsError [

	self
		should: [ ShipPosition createWith: 1 and: 10 and: -2 ]
		raiseErrorWithMessageText:
		'Player lap cannot be negative.'
]

{ #category : 'tests' }
ShipPositionTest >> test013WhenComparingDistancesThenACompletedLapCountsMoreThanAnyTileOfThePreviousLap [

	| aShipInANewLap aShipEndingTheFirstLap aBoardLength parsecsPerTile |
	aBoardLength := 10.
	parsecsPerTile := 5.
	aShipInANewLap := ShipPosition createWith: 1 and: 1 and: 1.
	aShipEndingTheFirstLap := ShipPosition createWith: 2 and: 10 and: 0.
	self assert: (aShipInANewLap distanceTravelledWith: aBoardLength and: parsecsPerTile)
		> (aShipEndingTheFirstLap distanceTravelledWith: aBoardLength and: parsecsPerTile)
]

{ #category : 'tests' }
ShipPositionTest >> test014WhenAShipSurpassesTheBoardLengthMoreThanOnceThenItAddsEveryCompletedLap [

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 1 and: 0.
	anUpdatedShipPosition := (aShipPosition advanceTiles: 25) changeLapAndCorrectPositionWith: 10.
	self assert: anUpdatedShipPosition lap equals: 2.
	self assert: anUpdatedShipPosition position equals: 6
]

{ #category : 'tests' }
ShipPositionTest >> test015WhenAShipGoesBackThenItKeepsTheParsecsTravelledInsideItsTile [

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 5 and: 0 and: 3.
	anUpdatedShipPosition := aShipPosition goBackTiles: 2.
	self assert: (anUpdatedShipPosition distanceTravelledWith: 10 and: 5) equals: 18
]
