Class {
	#name : 'PlayerCreationTest',
	#superclass : 'InstanceCreationTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PlayerCreationTest >> testWhenTryingToCreateAPlayerWithoutNameThenItThrowsError [

	self
		should: [ ShipPlayerAssociation createWith: 1 and: '' ]
		raiseErrorWithMessageText: 'The name cannot be empty.'
]
