"
More than one Die
"
Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Dice class >> createWith: aSetOfDice [

	self validate: aSetOfDice.
	^ self new initializeWith: aSetOfDice
]

{ #category : 'validation' }
Dice class >> validate: aSetOfDice [

	aSetOfDice isEmpty ifTrue: [
		Error signal: 'There is should be at least one die in the set.' ]
]

{ #category : 'initialization' }
Dice >> initializeWith: aSetOfDice [

	dice := aSetOfDice 
]

{ #category : 'calculating' }
Dice >> throw [

	^ dice inject: 0 into: [ :accumulator :each | accumulator + each throw ]
]
