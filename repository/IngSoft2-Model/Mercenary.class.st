Class {
	#name : 'Mercenary',
	#superclass : 'PermanentCard',
	#instVars : [
		'allyId'
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
Mercenary >> sameTypeOfCard: arg1 [

	^ arg1 isMercenary
]
