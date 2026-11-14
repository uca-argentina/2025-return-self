Class {
	#name : 'ShipShield',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'shields'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
ShipShield class >> createFullWith: anId [

	^ self createWith: anId and: self fullShields
]

{ #category : 'creation' }
ShipShield class >> createWith: anId and: anAmountOfShields [

	self idShouldBeGreaterThanZero: anId.
	self shieldsShouldntBeLowerThanZero: anAmountOfShields.
	^ self new initializeWith: anId and: anAmountOfShields
]

{ #category : 'accessing' }
ShipShield class >> fullShields [

	^ 3
]

{ #category : 'error testing' }
ShipShield class >> shieldsShouldntBeLowerThanZero: anAmountOfShields [

	anAmountOfShields < 0 ifTrue: [
		Error signal: 'The SpaceShip cant have negative shields.' ]
]

{ #category : 'positioning' }
ShipShield >> forceAShieldReset [

	^ self class createFullWith: id
]

{ #category : 'initialization' }
ShipShield >> initializeWith: anId and: anAmountOfShields [

	id := anId.
	shields := anAmountOfShields
]

{ #category : 'accessing' }
ShipShield >> loseShields: anAmount [

	| newShields |
	newShields := shields - anAmount max: 0.
	^ self class createWith: id and: newShields
]

{ #category : 'testing' }
ShipShield >> needsRecovery [

	^ shields = 0
]

{ #category : 'accessing' }
ShipShield >> shields [

	"Used for testing os displaying"

	^ shields
]
