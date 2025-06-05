"
a Player Object

"
Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'lap',
		'shields',
		'skipATurn',
		'name',
		'position',
		'id'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Player class >> named: aName [

	self playerNameCantBeEmpty: aName.

	^ self new initializePlayerWithName: aName withPosition: 1 withLaps: 0 withShield: 3 withTurnSkipped: 0
]

{ #category : 'instance creation' }
Player class >> named: aName withPosition: aPosition [

	self playerNameCantBeEmpty: aName.
	self positionHasToBeAPositiveInteger: aPosition.

	^ self new initializePlayerWithName: aName withPosition: aPosition withLaps: 0 withShield: 3 withTurnSkipped: 0 
]

{ #category : 'instance creation' }
Player class >> named: aName withPosition: aPosition withLaps: aLap [

	self playerNameCantBeEmpty: aName.
	self positionHasToBeAPositiveInteger: aPosition.

	^ self new initializePlayerWithName: aName withPosition: aPosition withLaps: aLap withShield: 3 withTurnSkipped: 0 
]

{ #category : 'instance creation' }
Player class >> named: aName withPosition: aPosition withLaps: aLap withShield: aShield [

	self playerNameCantBeEmpty: aName.
	self positionHasToBeAPositiveInteger: aPosition.

	^ self new initializePlayerWithName: aName withPosition: aPosition withLaps: aLap withShield: aShield withTurnSkipped:0
	
]

{ #category : 'instance creation' }
Player class >> named: aName withPosition: aPosition withLaps: aLap withShield: aShield withTurnSkipped:aSkip [

	self playerNameCantBeEmpty: aName.
	self positionHasToBeAPositiveInteger: aPosition.

	^ self new initializePlayerWithName: aName withPosition: aPosition withLaps: aLap withShield: aShield withTurnSkipped:aSkip 
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
		  named: name
		  withPosition: aDistance + position
		  withLaps: lap
		  withShield: shields
]

{ #category : 'positioning' }
Player >> circleAroundTheTrackWithLength: boardLength [
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
			withShield: shields 
]

{ #category : 'comparing' }
Player >> equals: anotherPlayerStatus [
	"In our implementation, ID is a key field data, it is UNIQUE, and it represents the position in the array"

	^ id = anotherPlayerStatus id
]

{ #category : 'positioning' }
Player >> forceAShieldReset [
	
	^ self class
		  named: name
		  withPosition: position
		  withLaps: lap
		  withShield: 3 
]

{ #category : 'as yet unclassified' }
Player >> goBackTiles: aDistance [ 

	| newPosition |
	newPosition := position - aDistance.
	newPosition := newPosition max: 1.
		^ self class
		  named: name
		  withPosition: newPosition 
		  withLaps: lap
]

{ #category : 'as yet unclassified' }
Player >> goToFirstTile [
	position := 1.
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName withPosition: aPosition withLaps: aLap withShield:aShield withTurnSkipped: aSkip [

	name := aName.
	position := aPosition.
	lap := aLap.
	shields := aShield.
	skipATurn := aSkip
]

{ #category : 'accessing' }
Player >> lap [

	^ lap
]

{ #category : 'positioning' }
Player >> loseBattle [
	|turnsToSkip shieldLeft|
	turnsToSkip := 0.
	shieldLeft := shields -1	.
	shieldLeft = 0 ifTrue:[turnsToSkip := 2].
	
	^ self class
		  named: name
		  withPosition: 1
		  withLaps: lap
		  withShield: shieldLeft
		  withTurnSkipped: turnsToSkip 
]

{ #category : 'accessing' }
Player >> loseShield [
	shields := shields -1 
]

{ #category : 'accessing' }
Player >> name [

	^ name
]

{ #category : 'accessing' }
Player >> position [

	^ position
]

{ #category : 'positioning' }
Player >> resetShieldsAfter2TurnsWithout [
	|newShield|
	newShield := shields.
	(shields <= 0) ifTrue:[ skipATurn <= 0 ifTrue:[newShield:=3]].
	
	^ self class
		  named: name
		  withPosition: position
		  withLaps: lap
		  withShield: newShield 
]

{ #category : 'accessing' }
Player >> skipATurn [

	^ skipATurn > 0
]

{ #category : 'positioning' }
Player >> turnSkipped [

	^ self class
		  named: name
		  withPosition: position
		  withLaps: lap
		  withShield: shields
		  withTurnSkipped: skipATurn - 1
]
