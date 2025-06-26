Class {
	#name : 'SpaceShipComponent',
	#superclass : 'Object',
	#instVars : [
		'id'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
SpaceShipComponent class >> createWith: anId and: someData [

	self subclassResponsibility
]

{ #category : 'error testing' }
SpaceShipComponent class >> idShouldBeGreaterThanZero: anId [

	anId > 0 ifFalse: [
		Error signal: 'The SpaceShip ID should be greater than zero.' ]
]

{ #category : 'comparing' }
SpaceShipComponent >> equalsID: anotherPlayerStatus [
	"In our implementation, ID is a key field data, it is UNIQUE"

	^ id = anotherPlayerStatus id
]

{ #category : 'accessing' }
SpaceShipComponent >> id [

	^ id
]

{ #category : 'testing' }
SpaceShipComponent >> isShip [

	^ true
]
