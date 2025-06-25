Class {
	#name : 'Mercenary',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Mercenary class >> createWithAnId: anId and: allyId [

	self idShouldBeGreaterThanZero: anId.
	self idShouldBeGreaterThanZero: allyId.
	^ self new initializeWith: anId and: allyId
]

{ #category : 'error testing' }
Mercenary class >> idShouldBeGreaterThanZero: anId [

	anId > 0 ifFalse: [
		Error signal: 'The SpaceShip ID should be greater than zero.' ]
]

{ #category : 'testing' }
Mercenary >> isMercenary [ 

^true
]
