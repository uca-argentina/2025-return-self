"
DieSet class
"
Class {
	#name : 'DieSet',
	#superclass : 'Object',
	#instVars : [
		'setOfDie'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'Creation' }
DieSet class >> having: aSetOfDie [

	^ self new initializeWithDie: aSetOfDie
]

{ #category : 'initialization' }
DieSet >> initializeWithDie: aSetOfDie [

	setOfDie := aSetOfDie
]

{ #category : 'accessing' }
DieSet >> throw [

	| total |
	total := 0.

	setOfDie do: [ :dice | total := total + dice throw ].

	^ total
]
