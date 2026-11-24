Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#instVars : [
		'chosenShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Repeat class >> createWith: aChosenShip [

	^ self new initializeWith: aChosenShip
]

{ #category : 'playing' }
Repeat >> applyIn: aGame [

	self assertHasTarget: chosenShip.
	aGame repeatLastEffectOn: chosenShip
]

{ #category : 'initialization' }
Repeat >> initializeWith: aChosenShip [

	chosenShip := aChosenShip
]

{ #category : 'setup' }
Repeat >> setupWith: aTarget [

	^ self class createWith: aTarget
]
