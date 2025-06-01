"
A mock class for testing Effects located in a special tile.
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

{ #category : 'as yet unclassified' }
BoardForTesting class >> createWithTiles: totalTiles andEffects: aCollectionOfEffects [
	^self new initializeWithTiles: totalTiles andEffects: aCollectionOfEffects
]

{ #category : 'accessing' }
BoardForTesting >> applyEffectTriggeredByPlayerAt: anIndex to: players [
	| detectedEffect |
	detectedEffect := effects detect: [ :effect | effect tiles includes: ((players at: anIndex) position) ] ifNone:[^players ].
	^detectedEffect applyEffectOn: players triggeredByPlayerAt: anIndex 


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
