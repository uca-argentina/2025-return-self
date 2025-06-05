Class {
	#name : 'SpaceShipComponent',
	#superclass : 'Object',
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
