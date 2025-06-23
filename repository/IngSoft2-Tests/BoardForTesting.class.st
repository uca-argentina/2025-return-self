"
A Board mock object for testing
"
Class {
	#name : 'BoardForTesting',
	#superclass : 'Object',
	#instVars : [
		'tiles'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
BoardForTesting class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'creation tests' }
BoardForTesting class >> createWith: aCollectionOfTiles [

	self boardLengthMustBeGreaterThanThree: aCollectionOfTiles size.
	^ self new initializeWith: aCollectionOfTiles
]

{ #category : 'positioning' }
BoardForTesting >> applyEffectTriggeredBy: aPlayer [

	| detectedTile |
	detectedTile := tiles at: aPlayer position.
	^ detectedTile effect
]

{ #category : 'initialization' }
BoardForTesting >> initializeWith: aCollectionOfTiles [

	tiles := aCollectionOfTiles
]

{ #category : 'accessing' }
BoardForTesting >> parsecsPerTile [

^ (tiles at: 1) parsecs
]

{ #category : 'accessing' }
BoardForTesting >> totalTiles [
	^ tiles size.
]
