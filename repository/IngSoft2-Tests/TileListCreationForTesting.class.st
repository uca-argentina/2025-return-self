"
A mock object for testing tile creation with effects in a particular number of tile
"
Class {
	#name : 'TileListCreationForTesting',
	#superclass : 'Object',
	#instVars : [
		'tileList'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
TileListCreationForTesting class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'creation tests' }
TileListCreationForTesting class >> createTileListWith: aBoardLength [

	self boardLengthMustBeGreaterThanThree: aBoardLength.
	^ self new initializeTileListWith: aBoardLength
]

{ #category : 'accessing' }
TileListCreationForTesting >> at: anIndex put: anEffect [

	self effectCantBeInFirstTile: anIndex.
	self effectMustBeInsideTheBoardLength: anIndex.
	anEffect isWormhole ifTrue: [
		self wormhole: anEffect positionMustBeDifferentFromEndpoint: anIndex.
		self wormholeEndpointMustBeInside: anEffect ].

	tileList at: anIndex put: (Tile createWithEffect: anEffect)
]

{ #category : 'creation tests' }
TileListCreationForTesting >> effectCantBeInFirstTile: anIndex [

anIndex = 1 ifTrue: [ Error signal: 'Effect cant be in first tile.' ]
]

{ #category : 'creation tests' }
TileListCreationForTesting >> effectMustBeInsideTheBoardLength: anIndex [

tileList size < anIndex ifTrue: [ Error signal: 'Effect cant be outside the board.' ]
]

{ #category : 'initialization' }
TileListCreationForTesting >> initializeTileListWith: aBoardLength [

	tileList := (1 to: aBoardLength) collect: [ :x |
		  Tile createWithEffect: NoEffect create ]
]

{ #category : 'accessing' }
TileListCreationForTesting >> tileList [

	^ tileList
]

{ #category : 'creation tests' }
TileListCreationForTesting >> wormhole: aWormholeEffect positionMustBeDifferentFromEndpoint: anIndex [

	(aWormholeEffect endpointSameAs: anIndex) ifTrue: [
		Error signal: 'Wormhole ends must be different tiles.' ]
]

{ #category : 'creation tests' }
TileListCreationForTesting >> wormholeEndpointMustBeInside: aWormholeEffect [

	(aWormholeEffect endpointInside: tileList size) ifFalse: [
		Error signal: 'Wormhole endpoint must be inside.' ]
]
