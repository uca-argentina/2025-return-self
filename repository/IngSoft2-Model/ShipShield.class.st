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

{ #category : 'positioning' }
ShipShield >> forceAShieldReset [
	
	^ self class
		  named: name
		  withPosition: position
		  withLaps: lap
		  withShield: shield
]

{ #category : 'initialization' }
ShipShield >> initializeWith: anId and: anAmountOfShields [

	id := anId.
	shields := anAmountOfShields
]

{ #category : 'positioning' }
ShipShield >> loseBattle [
	|turnsToSkip shieldLeft|
	turnsToSkip := 0.
	shieldLeft := shields -1	.
	shieldLeft = 0 ifTrue:[turnsToSkip := 2].
	
	^ self class
		  named: name
		  withPosition: 1
		  withLaps: lap
		  withShield: shieldLeft
		  withTurnSkipped: turnsToSkip 
]

{ #category : 'accessing' }
ShipShield >> loseShield [
	shields := shields -1 
]
