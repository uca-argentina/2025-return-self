Class {
	#name : 'PlayerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PlayerTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: (error messageText) equals:
				errorMessage ]
]

{ #category : 'tests' }
PlayerTest >> testWhenAPlayerIsAskedItsNameThenReturnsItsName [

	| aPlayer |
	aPlayer := Player named: 'Juan'.

	self assert: aPlayer name equals: 'Juan'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithFloatPositionThenItThrowsError [

	self
		should: [ Player named: 'Juan' withPosition: 1.3 ]
		raise: Error
		withMessageText: 'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithNegativePositionThenItThrowsError [

	self
		should: [ Player named: 'Juan' withPosition: -10 ]
		raise: Error
		withMessageText: 'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
PlayerTest >> testWhenTryingToCreateAPlayerWithoutNameThenItThrowsError [

	self
		should: [ Player named: '' ]
		raise: Error
		withMessageText: 'The name cannot be empty.'
]
