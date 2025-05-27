Class {
	#name : 'PlayerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PlayerTest >> testWhenAPlayerIsAskedItsNameThenReturnsItsName [

	| aPlayer |
	aPlayer := Player named: 'Juan'.

	self assert: aPlayer name equals: 'Juan'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithFloatPositionThenItThrowsError [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Player named: 'Juan' withPosition: 1.3 ]
		raiseErrorWithMessageText:
		'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithNegativePositionThenItThrowsError [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Player named: 'Juan' withPosition: -10 ]
		raiseErrorWithMessageText:
		'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithoutNameThenItThrowsError [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Player named: '' ]
		raiseErrorWithMessageText: 'The name cannot be empty.'
]
