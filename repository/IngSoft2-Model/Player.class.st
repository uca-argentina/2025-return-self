"
a Player Object

"
Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'playerName',
		'playerPosition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Player class >> named: aName [

	self playerNameCantBeEmpty: aName.

	^ self new initializePlayerWithName: aName withPosition: 1.
]

{ #category : 'instance creation' }
Player class >> named: aName withPosition: aPosition [

	self playerNameCantBeEmpty: aName.
	self positionHasToBeAPositiveInteger: aPosition.

	^ self new initializePlayerWithName: aName withPosition: aPosition.
]

{ #category : 'testing' }
Player class >> playerNameCantBeEmpty: aName [

	(aName = '') ifTrue: [ Error signal: 'The name cannot be empty.' ]
]

{ #category : 'testing' }
Player class >> positionHasToBeAPositiveInteger: aPosition [

	(aPosition > 0 and: aPosition isInteger) ifFalse: [
		Error signal:
			'Player position cannot be lower than 1 or a float number.' ]
]

{ #category : 'accessing' }
Player >> advancePlayer: distance [
	|newPlayer|
	newPlayer:= self class named: playerName withPosition: distance + playerPosition.
	^newPlayer
]

{ #category : 'accessing' }
Player >> goThrough: wormhole [
	|newPlayer|
	newPlayer:=  wormhole applyEffectOn: self.
	^newPlayer
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName withPosition: aPosition [

	playerName := aName.
	playerPosition := aPosition.
]

{ #category : 'accessing' }
Player >> move: setOfDie with: wormhole [
	|aPlayer|
	aPlayer := self advancePlayer: setOfDie throw .			
	^aPlayer goThrough: wormhole
	
]

{ #category : 'accessing' }
Player >> name [

	^ playerName
]

{ #category : 'accessing' }
Player >> position [

	^ playerPosition
]
