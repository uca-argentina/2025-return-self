Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'sideA',
		'sideB',
		'setted'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Wormhole class >> notSetted [
	|unsettedWormhole|
	unsettedWormhole := self new.
	unsettedWormhole setted: false.
	^ unsettedWormhole 
]

{ #category : 'creation' }
Wormhole class >> oneEnd: sideA otherEnd: sideB [

	^ self new initializeOneEnd: sideA otherEnd: sideB
]

{ #category : 'as yet unclassified' }
Wormhole >> describe: player passingThrough: enter to: exit [

	^player name,' entered wormhole on ',enter asString,' and came out from ',exit asString,' - Then '.
]

{ #category : 'initialization' }
Wormhole >> initializeOneEnd: aSide otherEnd: anotherSide [

	sideA := aSide.
	sideB := anotherSide.
	setted:=true.
]

{ #category : 'as yet unclassified' }
Wormhole >> passThrough: player enter: enter exit: exit [

	player teleportTo: exit.
	^self describe: player passingThrough: enter to: exit 
]

{ #category : 'accessing' }
Wormhole >> setted:value [
	setted:=value
]

{ #category : 'positioning' }
Wormhole >> suckInIfEncounter: player [
	setted ifTrue:[
	player position = sideA ifTrue: [ ^self passThrough: player enter: sideA exit: sideB ].
	player position = sideB ifTrue: [ ^self passThrough: player enter: sideA exit: sideB ].
	].
	^''.
]
