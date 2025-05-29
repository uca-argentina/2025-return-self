Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles',
		'allEffects'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> createWithTiles: aNumberOfTiles [ 
	^ self new initializeWithTiles: aNumberOfTiles
]

{ #category : 'as yet unclassified' }
Board class >> createWithTiles: totalTiles andEffects: aCollectionOfEffects [ 
	^self new initializeWithTiles: totalTiles andEffects: aCollectionOfEffects 
]

{ #category : 'positioning' }
Board >> applyEffectOn: aSetOfPlayers onIndex: anIndex [ 
	| detectedEffect |
	detectedEffect := allEffects detect: [ :effect | effect tiles = ((aSetOfPlayers at: anIndex) position) ] ifNone: [^ aSetOfPlayers ].
	^detectedEffect applyEffectOn: aSetOfPlayers onIndex: anIndex 
]

{ #category : 'initialization' }
Board >> initializeWithTiles: aNumberOfTiles [ 
	tiles := aNumberOfTiles.
	self generateRandomEffects.
]

{ #category : 'initialization' }
Board >> initializeWithTiles: totalTiles andEffects: aCollectionOfEffects [
	tiles := totalTiles.
	allEffects := aCollectionOfEffects.
]

{ #category : 'accessing' }
Board >> totalTiles [
	^ tiles
]
