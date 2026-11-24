Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Board class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'creation' }
Board class >> createWith: aSetOfTiles [

	self boardLengthMustBeGreaterThanThree: aSetOfTiles size.
	self everyEffectMustFitItsTile: aSetOfTiles.
	self everyTileMustHaveTheSameLength: aSetOfTiles.
	^ self new initializeWithTiles: aSetOfTiles
]

{ #category : 'testing' }
Board class >> everyEffectMustFitItsTile: aSetOfTiles [

	aSetOfTiles withIndexDo: [ :tile :tileNumber |
		tile effect assertCanBeAt: tileNumber onBoardOf: aSetOfTiles size ]
]

{ #category : 'testing' }
Board class >> everyTileMustHaveTheSameLength: aSetOfTiles [

	(aSetOfTiles collect: [ :tile | tile parsecs ]) asSet size = 1 ifFalse: [
		Error signal: 'Every tile of the board must have the same length.' ]
]

{ #category : 'testing' }
Board >> assertHasTile: aTileNumber [

	(aTileNumber between: 1 and: tiles size) ifFalse: [
		Error signal: 'The tile is not on the board.' ]
]

{ #category : 'accessing' }
Board >> effectAt: aTileNumber [

	^ (tiles at: aTileNumber) effect
]

{ #category : 'initialization' }
Board >> initializeWithTiles: aSetOfTiles [

	tiles := aSetOfTiles
]

{ #category : 'accessing' }
Board >> parsecsPerTile [

	^ (tiles at: 1) parsecs
]

{ #category : 'accessing' }
Board >> tiles [

	^ tiles
]

{ #category : 'accessing' }
Board >> totalTiles [

	^ tiles size
]
