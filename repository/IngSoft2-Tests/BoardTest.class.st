Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BoardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: (error messageText) equals:
				errorMessage ]
]

{ #category : 'tests' }
BoardTest >> testCreationOfBoard [

	self
		should: [ Board withLenght: -10 ]
		raise: Error
		withMessageText: 'The length of the board must be greater than 3.'
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsAskedForLastTileItReturnsMaxLenght [

	| aBoard aNoEffectObject |
	aNoEffectObject := NoEffect new.
	aBoard := Board withLenght: 20 and: aNoEffectObject.

	self assert: aBoard lenght equals: 20
]
