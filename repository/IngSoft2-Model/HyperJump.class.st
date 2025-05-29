Class {
	#name : 'HyperJump',
	#superclass : 'Effect',
	#instVars : [
		'tile',
		'actualBuff',
		'initialBuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperJump class >> effectProbability [

^0.08
]

{ #category : 'initialization' }
HyperJump class >> initializeOnTile: aTile [
	^ self new initializeOnTile: aTile
]

{ #category : 'positioning' }
HyperJump >> applyEffectOn: aSetOfPlayers onIndex: anIndex [ 
			| aPlayer |
	aPlayer := aSetOfPlayers at: anIndex.
	aPlayer position = tile ifTrue: [
		aPlayer := aPlayer advanceTiles: actualBuff .
		self lowerBuff.
		 (aSetOfPlayers at: anIndex put: aPlayer).
		].
	^aSetOfPlayers 
]

{ #category : 'initialization' }
HyperJump >> initializeInTile: aTile withBuff: aBuff [
	tile := aTile.
	initialBuff := aBuff.
	actualBuff := aBuff.
]

{ #category : 'initialization' }
HyperJump >> initializeOnTile: aTile [ 
	tile := aTile.
	initialBuff := 5.
	actualBuff := 5.
]

{ #category : 'as yet unclassified' }
HyperJump >> lowerBuff [

	actualBuff := actualBuff -1.
	actualBuff < 1 ifTrue: [ actualBuff := initialBuff ]
]

{ #category : 'as yet unclassified' }
HyperJump >> tiles [
 ^tile
]
