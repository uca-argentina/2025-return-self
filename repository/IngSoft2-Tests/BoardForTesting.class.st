"
A Board mock object for testing
"
Class {
	#name : 'BoardForTesting',
	#superclass : 'Object',
	#instVars : [
		'tiles',
		'effects'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
BoardForTesting class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'as yet unclassified' }
BoardForTesting class >> createWithTiles: totalTiles andEffects: aCollectionOfEffects [
	
	self boardLengthMustBeGreaterThanThree: totalTiles.
	^self new initializeWithTiles: totalTiles andEffects: aCollectionOfEffects
]

{ #category : 'accessing' }
BoardForTesting >> applyEffectTriggeredByPlayerAt: anIndex to: players [

	| detectedEffect aPlayerPosition |
	aPlayerPosition := (players at: anIndex) position.
	detectedEffect := effects
		                  detect: [ :effect |
		                  effect tiles includes: aPlayerPosition ]
		                  ifNone: [ ^ players ].
	^ detectedEffect applyEffectOn: players triggeredByPlayerAt: anIndex
]

{ #category : 'accessing' }
BoardForTesting >> initializeWithTiles: aNumberOfTiles andEffects: aCollectionOfEffects [

	tiles:= aNumberOfTiles .
	effects:= aCollectionOfEffects.

]

{ #category : 'accessing' }
BoardForTesting >> tiles [ 
^effects
]

{ #category : 'accessing' }
BoardForTesting >> totalTiles [
	^ tiles.
]
