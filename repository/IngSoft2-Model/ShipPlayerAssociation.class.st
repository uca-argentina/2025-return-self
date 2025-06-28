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

{ #category : 'comparing' }
ShipPlayerAssociation >> equalsName: aName [
^ name = aName 
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

{ #category : 'tests - printing' }
ShipPlayerAssociation >> searchReferenceAndConcatName: positionsWithoutName [
	"Used for testing and printing"

	| playerPositionInfo |
	playerPositionInfo := positionsWithoutName
		                      detect: [ :each | self equalsID: (each at: 1) ]
		                      ifNone: [
		                      Error signal:
			                      'Fatal Error: A Ship Reference is lost.' ].
	^ String streamContents: [ :s |
		  s nextPutAll: 'Name: '.
		  s nextPutAll: name.
		  s nextPutAll: (playerPositionInfo at: 2) ]
]
