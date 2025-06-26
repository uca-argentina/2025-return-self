Class {
	#name : 'Speed',
	#superclass : 'PermanentCard',
	#instVars : [
		'chosenShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Speed class >> createWithAnId: anId and: chosenId [

	^ self new initializeWith: chosenId
]

{ #category : 'error testing' }
Speed class >> idShouldBeGreaterThanZero: anId [

	anId > 0 ifFalse: [
		Error signal: 'The SpaceShip ID should be greater than zero.' ]
]

{ #category : 'as yet unclassified' }
Speed >> applyBonusUsing: arg1 [

	^ arg1 + 1
]

{ #category : 'initialization' }
Speed >> initializeWith: anId [


	shipId := anId.

]

{ #category : 'testing' }
Speed >> isSpeed [

	^ true
]

{ #category : 'as yet unclassified' }
Speed >> sameTypeOfCard: aCard [

	^ aCard isSpeed
]

{ #category : 'as yet unclassified' }
Speed >> setupWith: context [

	context asOrderedCollection size = 1 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	context isShip ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].
	chosenShip := context
]
