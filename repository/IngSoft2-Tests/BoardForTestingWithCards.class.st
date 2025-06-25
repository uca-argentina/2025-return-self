Class {
	#name : 'BoardForTestingWithCards',
	#superclass : 'Object',
	#instVars : [
		'tiles',
		'cards'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
BoardForTestingWithCards class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'creation' }
BoardForTestingWithCards class >> createWith: aCollectionOfTiles and: aCollectionOfCards [

	self boardLengthMustBeGreaterThanThree: aCollectionOfTiles size.
	^ self new initializeWith: aCollectionOfTiles and: aCollectionOfTiles 
]

{ #category : 'positioning' }
BoardForTestingWithCards >> applyEffectTriggeredBy: aPlayer [

	| detectedTile |
	detectedTile := tiles at: aPlayer position.
	^ detectedTile effect
]

{ #category : 'initialization' }
BoardForTestingWithCards >> initializeWith: aCollectionOfTiles and: aCollectionOfCards [

	tiles := aCollectionOfTiles.
	cards := aCollectionOfCards
]

{ #category : 'accessing' }
BoardForTestingWithCards >> parsecsPerTile [

^ (tiles at: 1) parsecs
]

{ #category : 'initialization' }
BoardForTestingWithCards >> setOfCards [

	^ cards
]

{ #category : 'accessing' }
BoardForTestingWithCards >> totalTiles [
	^ tiles size.
]
