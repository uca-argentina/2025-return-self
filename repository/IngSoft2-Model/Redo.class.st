Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#instVars : [
		'chosenShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Redo class >> createWith: aShip [

	^ self new initializeWith: aShip
]

{ #category : 'accessing' }
Redo >> chosenShip [

	^ chosenShip
]

{ #category : 'comparing' }
Redo >> equalsACard: aCard [

	aCard isRedo ifTrue: [ ^ chosenShip = aCard chosenShip ].
	^ false
]

{ #category : 'initialization' }
Redo >> initializeWith: aShip [

	chosenShip := aShip
]

{ #category : 'testing' }
Redo >> isRedo [

	^ true
]

{ #category : 'comparing' }
Redo >> sameTypeOfCard: aCard [

	^ aCard isRedo
]

{ #category : 'setup' }
Redo >> setupWith: context [

	context asOrderedCollection size = 1 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	context isShip ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].
	^ self class createWith: context
]
