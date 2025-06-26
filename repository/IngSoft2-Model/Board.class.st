Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles',
		'lastEffectApplied'
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
	
	^ self new initializeWithTiles: aSetOfTiles
]

{ #category : 'positioning' }
Board >> applyEffectTriggeredBy: aPlayer [ 

	| detectedTile |
	
	detectedTile := tiles at: aPlayer position.
	 (detectedTile effect )isNoEffect ifTrue: [ ^ detectedTile effect. ].
	lastEffectApplied := detectedTile effect.

^ detectedTile effect.
]

{ #category : 'initialization' }
Board >> initializeWithTiles: aSetOfTiles [

	tiles := aSetOfTiles.
	lastEffectApplied := NoEffect create.

]

{ #category : 'accessing' }
Board >> lastEffectApplied [
	^ lastEffectApplied
]

{ #category : 'accessing' }
Board >> parsecsPerTile [

^ (tiles at: 1) parsecs
]

{ #category : 'accessing' }
Board >> tiles [ 
^tiles
]

{ #category : 'accessing' }
Board >> totalTiles [
	^ tiles size.
]
