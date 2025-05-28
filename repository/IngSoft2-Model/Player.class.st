"
a Player Object

"
Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'playerName',
		'playerPosition',
		'lap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Player class >> named: aName [

	self playerNameCantBeEmpty: aName.

	^ self new initializePlayerWithName: aName withPosition: 1
]

{ #category : 'instance creation' }
Player class >> named: aName withPosition: aPosition [

	self playerNameCantBeEmpty: aName.
	self positionHasToBeAPositiveInteger: aPosition.

	^ self new initializePlayerWithName: aName withPosition: aPosition
]

{ #category : 'instance creation' }
Player class >> named: aName withPosition: aPosition withLaps: aLap [

	self playerNameCantBeEmpty: aName.
	self positionHasToBeAPositiveInteger: aPosition.

	^ self new initializePlayerWithName: aName withPosition: aPosition withLaps: aLap
]

{ #category : 'testing' }
Player class >> playerNameCantBeEmpty: aName [

	aName = '' ifTrue: [ Error signal: 'The name cannot be empty.' ]
]

{ #category : 'testing' }
Player class >> positionHasToBeAPositiveInteger: aPosition [

	(aPosition > 0 and: aPosition isInteger) ifFalse: [
		Error signal:
			'Player position cannot be lower than 1 or a float number.' ]
]

{ #category : 'positioning' }
Player >> advanceTiles: aDistance [

	^ self class
		  named: playerName
		  withPosition: aDistance + playerPosition
		  withLaps: lap
]

{ #category : 'positioning' }
Player >> circleAroundTheTrackWithLength: boardLength [
	|amountOfBackTrack  newLap|
	newLap := 0.
	amountOfBackTrack := 0.
	playerPosition > boardLength ifTrue:
		[
			amountOfBackTrack := boardLength .
			newLap := 1.
		].
	^ self class
		  	named: playerName
		  	withPosition: playerPosition - amountOfBackTrack
		 	withLaps: lap + newLap
]

{ #category : 'as yet unclassified' }
Player >> goBackTiles: aDistance [ 

	| newPosition |
	newPosition := playerPosition - aDistance.
	newPosition := newPosition max: 1.
		^ self class
		  named: playerName
		  withPosition: newPosition 
		  withLaps: lap
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName withPosition: aPosition [

	playerName := aName.
	playerPosition := aPosition.
	lap := 0
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName withPosition: aPosition withLaps: aLap [

	playerName := aName.
	playerPosition := aPosition.
	lap := aLap
]

{ #category : 'accessing' }
Player >> lap [

	^ lap
]

{ #category : 'accessing' }
Player >> name [

	^ playerName
]

{ #category : 'accessing' }
Player >> position [

	^ playerPosition
]
