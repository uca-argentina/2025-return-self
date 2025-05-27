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

	|anErrorHandler|
	anErrorHandler := MyErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Player named: 'Juan' withPosition: 1.3 ]
		raise: Error
		withMessageText: 'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithNegativePositionThenItThrowsError [

	|anErrorHandler|
	anErrorHandler := MyErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Player named: 'Juan' withPosition: -10 ]
		raise: Error
		withMessageText: 'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithoutNameThenItThrowsError [

	|anErrorHandler|
	anErrorHandler := MyErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Player named: '' ]
		raise: Error
		withMessageText: 'The name cannot be empty.'
]
