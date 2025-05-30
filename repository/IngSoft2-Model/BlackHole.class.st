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
BlackHole >> applyEffectOn: aGroupOfPlayers onIndex: anIndex [
	| aPlayer |
	aPlayer := aGroupOfPlayers at: anIndex.
	aPlayer position = tile ifTrue: [
		aPlayer := aPlayer goBackTiles: debuff.
		 (aGroupOfPlayers at: anIndex put: aPlayer).
		].
	^aGroupOfPlayers 
	
]

{ #category : 'initialization' }
BlackHole >> initializeOnTile: aTile [ 
	tile := aTile.
	debuff := 4.
]

{ #category : 'initialization' }
BlackHole >> tiles [
 ^{tile}
]
