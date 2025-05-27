Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormholeTest >> testWhenWeCreateAWormholeWithBothEndsLessThanOneThenItRaisesAnError [

	| anErrorHandler |
	anErrorHandler := MyErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Wormhole oneEnd: -10 otherEnd: -10 ]
		raise: Error
		withMessageText: 'Both ends of the Wormhole must be greater than 1.'
]

{ #category : 'tests' }
WormholeTest >> testWhenWeCreateAWormholeWithEqualEndsThenItRaisesAnError [

	| anErrorHandler |
	anErrorHandler := MyErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Wormhole oneEnd: 2 otherEnd: 2 ]
		raise: Error
		withMessageText: 'Wormhole ends must be different tiles.'
]

{ #category : 'tests' }
WormholeTest >> testWhenWeCreateAWormholeWithFirstEndLessThanOneThenItRaisesAnError [

	| anErrorHandler |
	anErrorHandler := MyErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Wormhole oneEnd: -10 otherEnd: 2 ]
		raise: Error
		withMessageText: 'Both ends of the Wormhole must be greater than 1.'
]

{ #category : 'tests' }
WormholeTest >> testWhenWeCreateAWormholeWithSecondEndLessThanOneThenItRaisesAnError [

	| anErrorHandler |
	anErrorHandler := MyErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Wormhole oneEnd: 2 otherEnd: -10 ]
		raise: Error
		withMessageText: 'Both ends of the Wormhole must be greater than 1.'
]
