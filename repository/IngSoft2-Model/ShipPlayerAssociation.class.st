Class {
	#name : 'ShipPlayerAssociation',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
ShipPlayerAssociation class >> createWith: anId and: aName [

	self idShouldBeGreaterThanZero: anId.
	self playerNameCantBeEmpty: aName.
	^ self new initializeWith: anId and: aName
]

{ #category : 'testing' }
ShipPlayerAssociation class >> playerNameCantBeEmpty: aName [

	aName = '' ifTrue: [ Error signal: 'The name cannot be empty.' ]
]

{ #category : 'initialization' }
ShipPlayerAssociation >> initializeWith: anId and: aName [

	id := anId.
	name := aName
]

{ #category : 'accessing' }
ShipPlayerAssociation >> name [

	^ name
]
