Class {
	#name : 'Speed',
	#superclass : 'Card',
	#instVars : [
		'shipId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Speed class >> createWithAnId: anId [

	^ self new initializeWith: anId
]

{ #category : 'error testing' }
Speed class >> idShouldBeGreaterThanZero: anId [

	anId > 0 ifFalse: [
		Error signal: 'The SpaceShip ID should be greater than zero.' ]
]

{ #category : 'as yet unclassified' }
Speed >> applyBonusUsing: aThrow [ 
	^ aThrow + 1.
]

{ #category : 'as yet unclassified' }
Speed >> equalsCard: aCard [

	^ aCard isSpeed and: aCard shipId = shipId
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

{ #category : 'accessing' }
Speed >> shipId [

	^ shipId
]
