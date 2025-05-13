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
	self positionHasToBePositive: aPosition.

	^ self new initializePlayerWithName: aName withPosition: aPosition.
]

{ #category : 'testing' }
Player class >> playerNameCantBeEmpty: aName [

	(aName = '') ifTrue: [ Error signal: 'The name cannot be empty.' ]
]

{ #category : 'testing' }
Player class >> positionHasToBePositive: aPosition [

	(aPosition > 0) ifFalse: [ Error signal: 'Player position cannot be lower than 1.' ]
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName withPosition: aPosition [

	playerName := aName.
	playerPosition := aPosition.
]

{ #category : 'accessing' }
Player >> name [

	^ playerName
]

{ #category : 'accessing' }
Player >> position [

	^ playerPosition
]
