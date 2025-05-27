"
A special object that has a shortened version of the ""should:raise:withExceptionDo:"" message.
"
Class {
	#name : 'MyErrorHandler',
	#superclass : 'Object',
	#instVars : [
		'testcaseObject'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
MyErrorHandler class >> usingTestCase: aTestCase [

	^ self new initializeWithTestObject: aTestCase
]

{ #category : 'initialization' }
MyErrorHandler >> initializeWithTestObject: aTestObject [

	testcaseObject := aTestObject
]

{ #category : 'asserting' }
MyErrorHandler >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	testcaseObject
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
			testcaseObject assert: (error messageText) equals:
				errorMessage ]
]
