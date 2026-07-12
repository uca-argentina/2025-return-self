"
Not instanciable class, just to keep common methods

Test Counter: 26

Some test may appear with name tag ""test###DEPRECATED"". The reason for this is to avoid the loss of traceability and to see the correct incremental order of the tests.
"
Class {
	#name : 'TestUtils',
	#superclass : 'Object',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
TestUtils class >> should: aCodeBlock raiseWith: anErrorMessage [

	| testCase |
	testCase := TestCase new.
	testCase
		should: aCodeBlock
		raise: Error
		withExceptionDo: [ :error |
		testCase assert: error messageText equals: anErrorMessage ]
]
