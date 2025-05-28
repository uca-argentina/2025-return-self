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
BlackHole class >> initializeInTile: aTile withDebuff: aDebuff [
	^self new initializeOnTile: aTile withDebuff: aDebuff .
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
BlackHole >> initializeOnTile: aTile withDebuff: aDebuff [
	tile := aTile.
	debuff := aDebuff.
]
