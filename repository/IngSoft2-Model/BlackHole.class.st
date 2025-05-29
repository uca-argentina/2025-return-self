Class {
	#name : 'BlackHole',
	#superclass : 'Effect',
	#instVars : [
		'tile',
		'debuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
BlackHole class >> effectProbability [

^0.20
]

{ #category : 'initialization' }
BlackHole class >> initializeOnTile: aTile [ 
	^self new initializeOnTile: aTile .
]

{ #category : 'positioning' }
BlackHole >> applyEffectOn: aSetOfPlayers onIndex: anIndex [
	| aPlayer |
	aPlayer := aSetOfPlayers at: anIndex.
	aPlayer position = tile ifTrue: [
		aPlayer := aPlayer goBackTiles: debuff.
		 (aSetOfPlayers at: anIndex put: aPlayer).
		].
	^aSetOfPlayers 
	
]

{ #category : 'initialization' }
BlackHole >> initializeOnTile: aTile [ 
	tile := aTile.
	debuff := 4.
]

{ #category : 'initialization' }
BlackHole >> tiles [
 ^tile
]
