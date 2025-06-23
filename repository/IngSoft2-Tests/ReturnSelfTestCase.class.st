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

{ #category : 'creation tests' }
ReturnSelfTestCase >> createTileListWith: aBoardLength [

	^ (1 to: aBoardLength) collect: [ :x |
		  Tile createWithEffect: NoEffect new ]
]

{ #category : 'interaction loop' }
ReturnSelfTestCase >> play: aNumberOfTurns in: aGame [

	1 to: aNumberOfTurns do: [ :turnIterator |
	aGame nextPlayerThrowsDice ]
]

{ #category : 'asserting' }
ReturnSelfTestCase >> should: anErrorBlock raiseErrorWithMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'interaction loop' }
ReturnSelfTestCase >> skip: aNumberOfTurns in: aGame [

	1 to: aNumberOfTurns do: [ :turnIterator |
	aGame nextPlayerSkipsTurn ]
]
