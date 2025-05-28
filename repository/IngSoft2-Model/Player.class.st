"
a Player Object

"
Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'playerName',
		'playerPosition',
		'lap',
		'shields',
		'skipATurn'
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

{ #category : 'instance creation' }
Player class >> named: aName withPosition: aPosition withLaps: aLap withShield: aShield [

	self playerNameCantBeEmpty: aName.
	self positionHasToBeAPositiveInteger: aPosition.

	^ self new initializePlayerWithName: aName withPosition: aPosition withLaps: aLap withShield: aShield 
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
		  named: playerName
		  withPosition: aDistance + playerPosition
		  withLaps: lap
		  withShield: shields
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
			withShield: shields 
]

{ #category : 'positioning' }
Player >> forceAShieldReset [
	
	^ self class
		  named: playerName
		  withPosition: playerPosition
		  withLaps: lap
		  withShield: 3 
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
	lap := 0.
	shields := 3.
	skipATurn := 0
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName withPosition: aPosition withLaps: aLap [

	playerName := aName.
	playerPosition := aPosition.
	lap := aLap.
	shields := 3.
	skipATurn := 0
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName withPosition: aPosition withLaps: aLap withShield:aShield [

	playerName := aName.
	playerPosition := aPosition.
	lap := aLap.
	shields := aShield.
	skipATurn := 0
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName withPosition: aPosition withLaps: aLap withShield:aShield withTurnSkipped: aSkip [

	playerName := aName.
	playerPosition := aPosition.
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
		  named: playerName
		  withPosition: 1
		  withLaps: lap
		  withShield: shieldLeft
		  withTurnSkipped: turnsToSkip 
]

{ #category : 'accessing' }
Player >> loseShield [.

	shields := shields -1 
]

{ #category : 'accessing' }
Player >> name [

	^ playerName
]

{ #category : 'accessing' }
Player >> position [

	^ playerPosition
]

{ #category : 'positioning' }
Player >> resetShieldsAfter2TurnsWithout [
	|newShield|
	newShield := shields.
	(shields <= 0) ifTrue:[ skipATurn <= 0 ifTrue:[newShield:=3]].
	
	^ self class
		  named: playerName
		  withPosition: playerPosition
		  withLaps: lap
		  withShield: newShield 
]

{ #category : 'accessing' }
Player >> shields [

	^ shields 
]

{ #category : 'accessing' }
Player >> skipATurn [

	^ skipATurn > 0
]

{ #category : 'positioning' }
Player >> turnSkipped [

	^ self class
		  named: playerName
		  withPosition: playerPosition
		  withLaps: lap
		  withShield: shields
		  withTurnSkipped: skipATurn - 1
]
