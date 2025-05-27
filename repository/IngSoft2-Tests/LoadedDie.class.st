"
A Mock object
"
Class {
	#name : 'LoadedDie',
	#superclass : 'Object',
	#instVars : [
		'setOfRolls'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
LoadedDie class >> mockRollCantLowerThanOne: aRoll [

	aRoll < 1 ifTrue: [ Error signal: 'The roll cant be lower than one.' ]
]

{ #category : 'creation' }
LoadedDie class >> rolling: aRoll [

	self mockRollCantLowerThanOne: aRoll.

	^ self new initializeWithRoll: aRoll
]

{ #category : 'initialization' }
LoadedDie >> initializeWithRoll: aRoll [

	setOfRolls := aRoll
]

{ #category : 'accessing' }
LoadedDie >> throw [

	^ setOfRolls
]
