"
Abstract middle class for ""should:raise:withExceptionDo:"" abreviation
"
Class {
	#name : 'ReturnSelfTestCase',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
ReturnSelfTestCase class >> isAbstract [

	^ self == ReturnSelfTestCase
]

{ #category : 'asserting' }
ReturnSelfTestCase >> assert: aCollection equalsCollection: anotherCollection [

	aCollection size = anotherCollection size ifFalse: [ ^ false ].
	^ (1 to: aCollection size) allSatisfy: [ :i |
		  (aCollection at: i) = (anotherCollection at: i) ]
]

{ #category : 'asserting' }
ReturnSelfTestCase >> should: anErrorBlock raiseErrorWithMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage ]
]
