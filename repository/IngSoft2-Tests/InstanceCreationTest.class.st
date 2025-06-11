Class {
	#name : 'InstanceCreationTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
InstanceCreationTest class >> isAbstract [

	^ self == InstanceCreationTest
]

{ #category : 'asserting' }
InstanceCreationTest >> should: anErrorBlock raiseErrorWithMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage ]
]
