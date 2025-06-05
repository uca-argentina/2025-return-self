"
a Player Object

"
Class {
	#name : 'ShipPosition',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'lap',
		'name',
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
ShipPosition class >> createWith: anId and: aName [

	self idShouldBeGreaterThanZero: anId.
	self playerNameCantBeEmpty: aName.
	^ self new initializePlayerWith: anId withName: aName withPosition: 1 withLaps: 0
]

{ #category : 'creation' }
ShipPosition class >> createWith: anId and: aName and: aPosition and: aNumberOfLaps [

	self idShouldBeGreaterThanZero: anId.
	self playerNameCantBeEmpty: aName.
	self positionHasToBeAPositiveInteger: aPosition.
	self lapHasToBeAPositiveInteger: aNumberOfLaps.
	^ self new initializePlayerWith: anId withName: aName withPosition: aPosition withLaps: aNumberOfLaps
]

{ #category : 'testing' }
ShipPosition class >> lapHasToBeAPositiveInteger: aNumberOfLaps [

	(aNumberOfLaps >= 0 and: aNumberOfLaps isInteger) ifFalse: [
		Error signal:
			'Player lap cannot be negative or a float number.' ]
]

{ #category : 'testing' }
ShipPosition class >> playerNameCantBeEmpty: aName [

	aName = '' ifTrue: [ Error signal: 'The name cannot be empty.' ]
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
		  named: name
		  withPosition: aDistance + position
		  withLaps: lap
]

{ #category : 'positioning' }
ShipPosition >> circleAroundTheTrackWithLength: boardLength [
	|amountOfBackTrack  newLap|
	newLap := 0.
	amountOfBackTrack := 0.
	position > boardLength ifTrue:
		[
			amountOfBackTrack := boardLength .
			newLap := 1.
		].
	^ self class
		  	named: name
		  	withPosition: position - amountOfBackTrack
		 	withLaps: lap + newLap
]

{ #category : 'comparing' }
ShipPosition >> equals: anotherPlayerStatus [
	"In our implementation, ID is a key field data, it is UNIQUE"

	^ id = anotherPlayerStatus id
]

{ #category : 'positioning' }
ShipPosition >> goBackTiles: aDistance [ 

	| newPosition |
	newPosition := position - aDistance.
	newPosition := newPosition max: 1.
		^ self class
		  named: name
		  withPosition: newPosition 
		  withLaps: lap
]

{ #category : 'positioning' }
ShipPosition >> goToFirstTile [
	position := 1.
]

{ #category : 'initialization' }
ShipPosition >> initializePlayerWith: anId withName: aName withPosition: aPosition withLaps: aLap [

	id := anId.
	name := aName.
	position := aPosition.
	lap := aLap.
]

{ #category : 'accessing' }
ShipPosition >> lap [

	^ lap
]

{ #category : 'accessing' }
ShipPosition >> name [

	^ name
]

{ #category : 'accessing' }
ShipPosition >> position [

	^ position
]
