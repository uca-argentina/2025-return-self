Class {
	#name : 'Mercenary',
	#superclass : 'PermanentCard',
	#instVars : [
		'allyId',
		'masterShip',
		'slaveShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Mercenary class >> createWithAnId: anId and: allyId [

	self
		idShouldBeGreaterThanZero: anId;
		idShouldBeGreaterThanZero: allyId.
	^ self new initializeWith: anId and: allyId
]

{ #category : 'error testing' }
Mercenary class >> idShouldBeGreaterThanZero: anId [

	anId > 0 ifFalse: [
		Error signal: 'The SpaceShip ID should be greater than zero.' ]
]

{ #category : 'accessing' }
Mercenary >> allyId [

	^ allyId
]

{ #category : 'initialization' }
Mercenary >> initializeWith: anId and: anAllyId [


	shipId := anId.
	allyId := anAllyId 
]

{ #category : 'testing' }
Mercenary >> isMercenary [
	
	^ true
]

{ #category : 'as yet unclassified' }
Mercenary >> sameTypeOfCard: aCard [

	^ aCard isMercenary
]

{ #category : 'as yet unclassified' }
Mercenary >> setupWith: context [

	context asOrderedCollection size = 2 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	(context at: 1) isShip ifFalse: [ Error signal: 'Wrong type or order of parameters' ].
	(context at: 2) isShip ifFalse: [ Error signal: 'Wrong type or order of parameters' ].
	masterShip := context at: 1.
	slaveShip := context at: 2
]
