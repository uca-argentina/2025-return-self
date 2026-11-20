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

{ #category : 'creation' }
DieSet class >> having: aSetOfDie [

	self mustHaveAtLeastOneDie: aSetOfDie.
	^ self new initializeWithDie: aSetOfDie
]

{ #category : 'testing' }
DieSet class >> mustHaveAtLeastOneDie: aSetOfDie [

	aSetOfDie isEmpty ifTrue: [
		Error signal: 'You must have at least one die to play.' ]
]

{ #category : 'initialization' }
DieSet >> initializeWithDie: aSetOfDie [

	setOfDie := aSetOfDie
]

{ #category : 'accessing' }
DieSet >> throw [

	^ setOfDie sum: [ :dice | dice throw ]
]
