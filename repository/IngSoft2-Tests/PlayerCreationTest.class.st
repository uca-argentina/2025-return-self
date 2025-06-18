Class {
	#name : 'PlayerCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PlayerCreationTest >> test01WhenTryingToCreateAPlayerWithoutNameThenItThrowsError [

	self
		should: [ ShipPlayerAssociation createWith: 1 and: '' ]
		raiseErrorWithMessageText: 'The name cannot be empty.'
]
