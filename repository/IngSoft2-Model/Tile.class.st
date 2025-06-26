Class {
	#name : 'Tile',
	#superclass : 'Object',
	#instVars : [
		'effect',
		'parsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Tile class >> createWithEffect: anEffect [

	^ self new initializeTileWithEffect: anEffect and: 5
]

{ #category : 'creation' }
Tile class >> createWithEffect: anEffect and: parsecsNumber [

	^ self new initializeTileWithEffect: anEffect and: parsecsNumber
]

{ #category : 'accessing' }
Tile >> effect [

^effect 
]

{ #category : 'testing' }
Tile >> hasNoEffect [

	^ effect isNoEffect
]

{ #category : 'initialization' }
Tile >> initializeTileWithEffect: anEffect and: parsecsNumber [

	effect := anEffect.
	parsecs := parsecsNumber
]

{ #category : 'accessing' }
Tile >> parsecs [

	^ parsecs
]
