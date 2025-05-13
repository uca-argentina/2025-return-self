"
A wormhole Class
"
Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'sideA',
		'sideB'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Wormhole class >> oneEnd: sideA otherEnd: sideB [

	^ self new initializeOneEnd: sideA otherEnd: sideB
]

{ #category : 'positioning' }
Wormhole >> applyEffect: player [

	player position = sideA ifTrue: [ ^self passThrough: player enter: sideA exit: sideB ].
	player position = sideB ifTrue: [ ^self passThrough: player enter: sideB exit: sideA ].
	^''.
]

{ #category : 'initialization' }
Wormhole >> initializeOneEnd: aSide otherEnd: anotherSide [

	sideA := aSide.
	sideB := anotherSide.

]

{ #category : 'as yet unclassified' }
Wormhole >> passThrough: player enter: enter exit: exit [

	player teleportTo: exit.
	^ player name,' entered wormhole on ',enter asString,' and came out from ',exit asString,' - Then '.
]
