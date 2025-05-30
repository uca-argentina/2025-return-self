Class {
	#name : 'NoEffect',
	#superclass : 'Effect',
	#instVars : [
		'tile'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
NoEffect class >> effectProbability [

^0.40
]

{ #category : 'initialization' }
NoEffect class >> initializeOnTile: aTile [
^ self new initializeOnTile: aTile .
]

{ #category : 'positioning' }
NoEffect >> applyEffectOn: aSetOfPlayers onIndex: anIndex [
	^aSetOfPlayers 
]

{ #category : 'initialization' }
NoEffect >> initializeOnTile: aTile [
	tile := aTile.
]

{ #category : 'initialization' }
NoEffect >> tiles [
 ^{tile}
]
