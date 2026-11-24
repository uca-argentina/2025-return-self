Class {
	#name : 'Distance',
	#superclass : 'Object',
	#instVars : [
		'amount'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Distance class >> amountCantBeNegative: anAmount [

	anAmount < 0 ifTrue: [ Error signal: 'A distance cannot be negative.' ]
]

{ #category : 'creation' }
Distance class >> of: anAmount [

	self amountCantBeNegative: anAmount.
	^ self new initializeWith: anAmount
]

{ #category : 'converting' }
Distance >> asParsecs [

	self subclassResponsibility
]

{ #category : 'initialization' }
Distance >> initializeWith: anAmount [

	amount := anAmount
]
