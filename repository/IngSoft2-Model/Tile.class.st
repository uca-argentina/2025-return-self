Class {
	#name : 'Tile',
	#superclass : 'Object',
	#instVars : [
		'effect',
		'length'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Tile class >> createWithEffect: anEffect [

	^ self createWithEffect: anEffect and: self defaultLength
]

{ #category : 'creation' }
Tile class >> createWithEffect: anEffect and: aLength [

	self lengthMustBeGreaterThanZero: aLength.
	^ self new initializeTileWithEffect: anEffect and: aLength
]

{ #category : 'accessing' }
Tile class >> defaultLength [

	^ Parsecs of: 5
]

{ #category : 'testing' }
Tile class >> lengthMustBeGreaterThanZero: aLength [

	aLength asParsecs > 0 ifFalse: [
		Error signal: 'A tile must be longer than zero parsecs.' ]
]

{ #category : 'accessing' }
Tile >> effect [

	^ effect
]

{ #category : 'initialization' }
Tile >> initializeTileWithEffect: anEffect and: aLength [

	effect := anEffect.
	length := aLength
]

{ #category : 'accessing' }
Tile >> parsecs [

	^ length asParsecs
]
