Class {
	#name : 'ShipShield',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'id',
		'shields'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
ShipShield class >> createWith: anId and: anAmountOfShields [

	self idShouldBeGreaterThanZero: anId.
	self shieldsShouldntBeLowerThanZero: anAmountOfShields.
	^ self new initializeWith: anId and: anAmountOfShields
]

{ #category : 'error testing' }
ShipShield class >> shieldsShouldntBeLowerThanZero: anAmountOfShields [

	anAmountOfShields < 0 ifTrue: [
		Error signal: 'The SpaceShip cant have negative shields.' ]
]

{ #category : 'initialization' }
ShipShield >> initializeWith: anId and: anAmountOfShields [

	id := anId.
	shields := anAmountOfShields
]
