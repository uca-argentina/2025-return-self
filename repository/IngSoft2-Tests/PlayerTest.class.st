Class {
	#name : 'PlayerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PlayerTest >> testWhenAPlayerIsAskedItsNameThenReturnsItsName [

	| aPlayer |
	aPlayer := ShipPosition createWith: 1 and: 'Juan'.

	self assert: aPlayer name equals: 'Juan'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithFloatPositionThenItThrowsError [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ ShipPosition createWith: 1 and: 'Juan' and: 1.3 and: 0 ]
		raiseErrorWithMessageText:
		'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithNegativePositionThenItThrowsError [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ ShipPosition createWith: 1 and: 'Juan' and: -10 and: 0 ]
		raiseErrorWithMessageText:
		'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithoutNameThenItThrowsError [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ ShipPosition createWith: 1 and: '' ]
		raiseErrorWithMessageText: 'The name cannot be empty.'
]
