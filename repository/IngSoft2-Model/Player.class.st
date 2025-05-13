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

	^ self new initializePlayerWithName: aName withPosition: 1.
]

{ #category : 'instance creation' }
Player class >> named: aName withPosition: aPosition [

	^ self new initializePlayerWithName: aName withPosition: aPosition.
]

{ #category : 'printing' }
Player >> describeMove [

	^ self name , ' landed on ' , self position asString
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName withPosition: aPosition [

	playerName := aName.
	playerPosition := aPosition.
]

{ #category : 'accessing' }
Player >> move: aDistance [

	playerPosition := playerPosition + aDistance.
	^ self describeMove
]

{ #category : 'accessing' }
Player >> name [

	^ playerName
]

{ #category : 'accessing' }
Player >> position [

	^ playerPosition
]

{ #category : 'accessing' }
Player >> teleportTo: position [

	playerPosition := position.
	^ self describeMove
]
