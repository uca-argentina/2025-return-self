"
A special object that has a shortened version of the ""should:raise:withExceptionDo:"" message.
"
Class {
	#name : 'ReturnSelfErrorHandler',
	#superclass : 'Object',
	#instVars : [
		'testcaseObject'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'creation' }
ReturnSelfErrorHandler class >> usingTestCase: aTestCase [

	^ self new initializeWithTestObject: aTestCase
]

{ #category : 'initialization' }
ReturnSelfErrorHandler >> initializeWithTestObject: aTestObject [

	testcaseObject := aTestObject
]

{ #category : 'asserting' }
ReturnSelfErrorHandler >> should: anErrorBlock raiseErrorWithMessageText: anErrorMessage [

	testcaseObject
		should: anErrorBlock
		raise: Error
		withExceptionDo: [ :error |
			testcaseObject assert: error messageText equals: anErrorMessage ]
]
