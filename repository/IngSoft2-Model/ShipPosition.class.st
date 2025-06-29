Class {
	#name : 'ShipPosition',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'lap',
		'position',
		'parsec'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
ShipPosition class >> createWith: anId and: aNumberOfLaps [

	self idShouldBeGreaterThanZero: anId.
	self lapCantBeNegative: aNumberOfLaps.
	^ self new initializeWith: anId and: 1 and: aNumberOfLaps and: 0
]

{ #category : 'creation' }
ShipPosition class >> createWith: anId and: aPosition and: aNumberOfLaps [
	self idShouldBeGreaterThanZero: anId.
	self positionHasToBePositive: aPosition.
	self lapCantBeNegative: aNumberOfLaps.
	^ self new initializeWith: anId and: aPosition and: aNumberOfLaps and: 0
]

{ #category : 'creation' }
ShipPosition class >> createWith: anId and: aPosition and: aNumberOfLaps and: aParsecNumber [
	self idShouldBeGreaterThanZero: anId.
	self positionHasToBePositive: aPosition.
	self lapCantBeNegative: aNumberOfLaps.
	self parsecNumberCantBeNegative: aParsecNumber.
	^ self new initializeWith: anId and: aPosition and: aNumberOfLaps and: aParsecNumber 
]

{ #category : 'testing' }
ShipPosition class >> lapCantBeNegative: aNumberOfLaps [

	aNumberOfLaps >= 0 ifFalse: [
		Error signal: 'Player lap cannot be negative.' ]
]

{ #category : 'testing' }
ShipPosition class >> parsecNumberCantBeNegative: aParsecNumber [

aParsecNumber >= 0 ifFalse: [
		Error signal: 'Tile parsec number cannot be negative.' ]
]

{ #category : 'testing' }
ShipPosition class >> positionHasToBePositive: aPosition [

	aPosition > 0 ifFalse: [
		Error signal:
			'Player position cannot be lower than 1 or a float number.' ]
]

{ #category : 'positioning' }
ShipPosition >> advanceParsecs: aNumberOfParsecs [

	^ self class
		  createWith: id
		  and: position
		  and: lap
		  and: parsec + aNumberOfParsecs
]

{ #category : 'positioning' }
ShipPosition >> advanceTiles: aDistance [

	^ self class
		  createWith: id
		  and: position + aDistance
		  and: lap
		  and: parsec
]

{ #category : 'accessing' }
ShipPosition >> calculateDelta: anotherPosition [

^ anotherPosition - position
]

{ #category : 'positioning' }
ShipPosition >> changeLapAndCorrectPositionWith: aBacktrackDistance [

	^ self class createWith: id and: position - aBacktrackDistance and: lap + 1 and: parsec
]

{ #category : 'positioning' }
ShipPosition >> changePositionAndCorrectParsecsWith: aBacktrackDistance [

	| amountOfPositionsChanged newParsec |
	amountOfPositionsChanged := parsec // aBacktrackDistance.
	newParsec := parsec \\ aBacktrackDistance.
	^ self class
		  createWith: id
		  and: position + amountOfPositionsChanged
		  and: lap
		  and: newParsec
]

{ #category : 'accessing' }
ShipPosition >> distanceTravelledWith: boardLength and: parsecsPerTile [

	^ lap * boardLength + (position * parsecsPerTile) + parsec
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

	^ self class
		  createWith: id
		  and: lap
]

{ #category : 'comparing' }
ShipPosition >> inSafeZone [

	^ position = 1
]

{ #category : 'initialization' }
ShipPosition >> initializeWith: anId and: aPosition and: aLap and: aParsecNumber [

	id := anId.
	position := aPosition.
	lap := aLap.
	parsec := aParsecNumber
]

{ #category : 'accessing' }
ShipPosition >> lap [
"Used for testing os displaying"
	^ lap
]

{ #category : 'comparing' }
ShipPosition >> lapGreaterOrEqualThan: aNumberOfLaps [
	^ lap >= aNumberOfLaps
]

{ #category : 'comparing' }
ShipPosition >> parsecGreaterThan: aLength [

	^ parsec > aLength
]

{ #category : 'accessing' }
ShipPosition >> position [
"Used for testing os displaying"
	^ position
]

{ #category : 'comparing' }
ShipPosition >> positionGreaterThan: aLength [

	^ position > aLength
]

{ #category : 'comparing' }
ShipPosition >> samePositionAs: aPlayer [

	^ position = aPlayer position
]
