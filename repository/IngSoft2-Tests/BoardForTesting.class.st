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
BoardForTesting >> applyEffectOn: aSetOfPlayers onIndex: anIndex [ 
	| detectedEffect |
	detectedEffect := effects detect: [ :effect | effect tiles includes: ((aSetOfPlayers at: anIndex) position) ] ifNone:[^aSetOfPlayers ].
	^detectedEffect applyEffectOn: aSetOfPlayers onIndex: anIndex 


]

{ #category : 'accessing' }
BoardForTesting >> initializeWithTiles: aNumberOfTiles andEffects: aCollectionOfEffects [

	tiles:= aNumberOfTiles .
	effects:= aCollectionOfEffects 

]

{ #category : 'accessing' }
BoardForTesting >> totalTiles [
	^ tiles.
]
