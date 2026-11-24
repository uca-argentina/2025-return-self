"
A mock object for testing tile creation with effects in a particular number of tile
"
Class {
	#name : 'TileListCreationForTesting',
	#superclass : 'Object',
	#instVars : [
		'tileList',
		'tileLength'
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

	^ self createTileListWith: aBoardLength and: Tile defaultLength
]

{ #category : 'creation tests' }
TileListCreationForTesting class >> createTileListWith: aBoardLength and: aTileLength [

	self boardLengthMustBeGreaterThanThree: aBoardLength.
	^ self new initializeTileListWith: aBoardLength and: aTileLength
]

{ #category : 'accessing' }
TileListCreationForTesting >> at: anIndex put: anEffect [

	self effectCantBeInFirstTile: anIndex.
	self effectMustBeInsideTheBoardLength: anIndex.
	anEffect assertCanBeAt: anIndex onBoardOf: tileList size.
	tileList
		at: anIndex
		put: (Tile createWithEffect: anEffect and: tileLength)
]

{ #category : 'creation tests' }
TileListCreationForTesting >> effectCantBeInFirstTile: anIndex [

	anIndex = 1 ifTrue: [ Error signal: 'Effect cant be in first tile.' ]
]

{ #category : 'creation tests' }
TileListCreationForTesting >> effectMustBeInsideTheBoardLength: anIndex [

	tileList size < anIndex ifTrue: [
		Error signal: 'Effect cant be outside the board.' ]
]

{ #category : 'initialization' }
TileListCreationForTesting >> initializeTileListWith: aBoardLength and: aTileLength [

	tileLength := aTileLength.
	tileList := (1 to: aBoardLength) collect: [ :x |
		Tile createWithEffect: NoEffect create and: aTileLength ]
]

{ #category : 'accessing' }
TileListCreationForTesting >> tileList [

	^ tileList
]
