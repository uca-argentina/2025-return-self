Class {
	#name : 'ShipPositionTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipPositionTest >> test01WhenTellingAShipToAdvanceADistanceThenItReturnsANewShipWithNewPosition [

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 1 and: 0.
	anUpdatedShipPosition := aShipPosition advanceTiles: 10.

	self assert: anUpdatedShipPosition position equals: 11.
	self deny: aShipPosition position equals: 11 "Here you can be sure that original object is not affected"
]

{ #category : 'tests' }
ShipPositionTest >> test02WhenTellingAShipToGoBackADistanceThenItReturnsANewShipWithNewPosition [

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 11 and: 0.
	anUpdatedShipPosition := aShipPosition goBackTiles: 10.

	self assert: anUpdatedShipPosition position equals: 1.
	self deny: aShipPosition position equals: 1 "Here you can be sure that original object is not affected"
]

{ #category : 'tests' }
ShipPositionTest >> test03WhenAShipGoesBackADistanceGreaterThanItsPositionThenItReturnsAShipInFirstTileSameLap [
	"We assumed ships cant lose laps"

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 5 and: 2.
	anUpdatedShipPosition := aShipPosition goBackTiles: 10.

	self assert: anUpdatedShipPosition position equals: 1.
	self assert: anUpdatedShipPosition lap equals: 2
]

{ #category : 'tests' }
ShipPositionTest >> test04WhenAShipIsToldToResetLapThenItReturnsToFirstTileSameLap [
	"We assumed ships cant lose laps"

	| aShipPosition anUpdatedShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 15 and: 2.
	anUpdatedShipPosition := aShipPosition goToFirstTile.

	self assert: anUpdatedShipPosition position equals: 1.
	self assert: anUpdatedShipPosition lap equals: 2
]

{ #category : 'tests' }
ShipPositionTest >> test05WhenShipIsInFirstTileThenItIsInSafeZone [

	| aShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 1 and: 0.

	self assert: aShipPosition inSafeZone
]

{ #category : 'tests' }
ShipPositionTest >> test06WhenShipIsNotInFirstTileThenItIsNotInSafeZone [

	| aShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 4 and: 0.

	self deny: aShipPosition inSafeZone
]

{ #category : 'tests' }
ShipPositionTest >> test07AShipKnowsToAnswerIfItsPositionIsGreaterThanAValue [

	| aShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 4 and: 0.

	self deny: (aShipPosition positionGreaterThan: 5).
	self assert: (aShipPosition positionGreaterThan: 2)
]

{ #category : 'tests' }
ShipPositionTest >> test08AShipKnowsToAnswerIfItsLapIsGreaterOrEqualThanAValue [

	| aShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 5 and: 1.

	self deny: (aShipPosition lapGreaterOrEqualThan: 2).
	self assert: (aShipPosition lapGreaterOrEqualThan: 1)
]

{ #category : 'tests' }
ShipPositionTest >> test09WhenTwoShipsAreInSamePositionThenTheyAreAware [

	| aShipPosition anotherShipPosition |
	aShipPosition := ShipPosition createWith: 1 and: 5 and: 1.
	anotherShipPosition := ShipPosition createWith: 1 and: 5 and: 2.

	self assert: (aShipPosition samePositionAs: anotherShipPosition)
]

{ #category : 'tests' }
ShipPositionTest >> test10WhenAShipSurpassesTheBoardLengthThenItStartsANewLapWithCalculatedPosition [
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
