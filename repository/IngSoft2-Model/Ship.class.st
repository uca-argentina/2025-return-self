"
A ship
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'id'
	],
	#category : 'IngSoft2-Model-Base',
	#package : 'IngSoft2-Model',
	#tag : 'Base'
}

{ #category : 'creation' }
Ship class >> createWith: anId [
	
	self validateId: anId.
	^ self new initializeWith: anId and: 1
]

{ #category : 'creation' }
Ship class >> createWith: anId and: aPosition [
	
	self validateId: anId.
	self validatePosition: aPosition.
	^ self new initializeWith: anId and: aPosition
]

{ #category : 'validation' }
Ship class >> validateId: anId [

	anId < 1 ifTrue: [ Error signal: 'ID must be greater than 1.' ]
]

{ #category : 'validation' }
Ship class >> validatePosition: aPosition [

	aPosition < 1 ifTrue: [
		Error signal: 'Position must be greater than 1.' ]
]

{ #category : 'copying' }
Ship >> copy [

	^ self class createWith: id and: position
]

{ #category : 'comparing' }
Ship >> equals: anotherShip [
	"This would be a complete comparison, but I'll go for another alternative since id is unique for every player
	^ id = anotherPlayer id and:
		  (name = anotherPlayer name and: (ship equals: anotherPlayer ship))"

	^ id = anotherShip id
]

{ #category : 'accessing' }
Ship >> id [

	^ id
]

{ #category : 'initialization' }
Ship >> initializeWith: anId and: aPosition [

	position := aPosition.
	id := anId.
	"name := aName"
]

{ #category : 'accessing' }
Ship >> isIn: aPosition [

	^ position = aPosition
]

{ #category : 'move' }
Ship >> moveForward: aDistance [
	"Should I include a validation for the distance to be positive?"

	^ self class createWith: id and: position + aDistance
]

{ #category : 'comparing' }
Ship >> positionLowerThan: aNumber [

	^ position < aNumber
]

{ #category : 'showing' }
Ship >> retrievePosition [

	^ 'Ship ID: ' , id asString , ', Position: ' , position asString
	  , '.'
]
