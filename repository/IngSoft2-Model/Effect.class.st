Class {
	#name : 'Effect',
	#superclass : 'Object',
	#instVars : [
		'tile'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Effect class >> createOnTile: aTile [
^ self new initializeOnTile: aTile .
]

{ #category : 'initialization' }
Effect class >> effectProbability [

self shouldBeImplemented.
]

{ #category : 'positioning' }
Effect >> applyEffectOn: aGroupOfPlayers triggeredByPlayerAt: anIndex [

	self subclassResponsibility
]

{ #category : 'initialization' }
Effect >> initializeOnTile: aTile [
tile := aTile 
]

{ #category : 'initialization' }
Effect >> tiles [ 
 ^{tile}
]
