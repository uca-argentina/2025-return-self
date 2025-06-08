"
a Player Object

"
Class {
	#name : 'ShipPosition',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'lap',
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
ShipPosition class >> createWith: anId and: aNumberOfLaps [

	self idShouldBeGreaterThanZero: anId.
	self lapCantBeANegativeInteger: aNumberOfLaps.
	^ self new initializeWith: anId and: 1 and: aNumberOfLaps
]

{ #category : 'creation' }
ShipPosition class >> createWith: anId and: aPosition and: aNumberOfLaps [
	self idShouldBeGreaterThanZero: anId.
	self positionHasToBeAPositiveInteger: aPosition.
	self lapCantBeANegativeInteger: aNumberOfLaps.
	^ self new initializeWith: anId and: aPosition and: aNumberOfLaps
]

{ #category : 'testing' }
ShipPosition class >> lapCantBeANegativeInteger: aNumberOfLaps [

	(aNumberOfLaps >= 0 and: aNumberOfLaps isInteger) ifFalse: [
		Error signal:
			'Player lap cannot be negative or a float number.' ]
]

{ #category : 'testing' }
ShipPosition class >> positionHasToBeAPositiveInteger: aPosition [

	(aPosition > 0 and: aPosition isInteger) ifFalse: [
		Error signal:
			'Player position cannot be lower than 1 or a float number.' ]
]

{ #category : 'positioning' }
ShipPosition >> advanceTiles: aDistance [

	^ self class
		  createWith: id
		  and: aDistance + position
		  and: lap
]

{ #category : 'positioning' }
ShipPosition >> goBackTiles: aDistance [

	| newPosition |
	newPosition := position - aDistance.
	newPosition := newPosition max: 1.
	^ self class
		  createWith: id
		  and: newPosition
		  and: lap
]

{ #category : 'positioning' }
ShipPosition >> goToFirstTile [
	^ self class createWith: id and: 1 and: lap
]

{ #category : 'initialization' }
ShipPosition >> initializeWith: anId and: aPosition and: aLap [

	id := anId.
	position := aPosition.
	lap := aLap.
]

{ #category : 'accessing' }
ShipPosition >> lap [

	^ lap
]

{ #category : 'accessing' }
ShipPosition >> position [

	^ position
]

{ #category : 'comparing' }
ShipPosition >> samePositionAs: aPlayer [

	^ position = aPlayer position
]
