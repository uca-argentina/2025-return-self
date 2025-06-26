Class {
	#name : 'Speed',
	#superclass : 'PermanentCard',
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

{ #category : 'as yet unclassified' }
Speed >> equalsCard: aCard [

	aCard isSpeed ifTrue: [ ^ shipId = aCard shipId ].
	^ false
]

{ #category : 'initialization' }
Speed >> initializeWith: anId [


	shipId := anId.

]

{ #category : 'testing' }
Speed >> isSpeed [

	^ true
]
