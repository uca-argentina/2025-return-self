Class {
	#name : 'PlayerTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PlayerTest >> test01WhenAPlayerIsAskedItsNameThenReturnsItsName [

	| aPlayer |
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.

	self assert: aPlayer name equals: 'Juan'
]

{ #category : 'tests' }
PlayerTest >> test01WhenTryingToCreateAPlayerWithoutNameThenItThrowsError [

	self
		should: [ ShipPlayerAssociation createWith: 1 and: '' ]
		raiseErrorWithMessageText: 'The name cannot be empty.'
]
