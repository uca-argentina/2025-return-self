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

{ #category : 'creation' }
LoadedDie class >> rolling: aRoll [

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
