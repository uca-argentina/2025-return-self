Class {
	#name : 'Tile',
	#superclass : 'Object',
	#instVars : [
		'effect',
		'parsec'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Tile class >> createWithPosition: aPosition andEffect: anEffect [ 
	self parsecsMustBePositive: aPosition.
	^self new initializeTileWithPosition: aPosition andEffect: anEffect.
]

{ #category : 'as yet unclassified' }
Tile class >> parsecsMustBePositive: aPosition [

aPosition <= 0 ifTrue: [ Error signal: 'a tile must have positive parsecs' ]

]

{ #category : 'initialization' }
Tile >> initializeTileWithPosition: aPosition andEffect: anEffect [

parsec := aPosition .
effect := anEffect .
]
