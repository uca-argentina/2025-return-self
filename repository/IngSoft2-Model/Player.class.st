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
	^self new initializePlayerWithName: aName.
	
]

{ #category : 'initialization' }
Player >> initializePlayerWithName: aName [ 
	playerName:=aName.
	playerPosition := 1.
]

{ #category : 'accessing' }
Player >> move: aDistance [ 
	playerPosition := (playerPosition + aDistance )
]

{ #category : 'accessing' }
Player >> name [
	^playerName.
]

{ #category : 'accessing' }
Player >> position [
	^playerPosition.
]
