Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormholeTest >> testWhenWeCreateAWormholeWithAtLeastOneEndLessThanOneThenItRaisesAnError [

	| anErrorHandler |
	anErrorHandler := MyErrorHandler usingTestCase: self.

	anErrorHandler
		should: [ Wormhole oneEnd: -10 otherEnd: 2 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'.
	anErrorHandler
		should: [ Wormhole oneEnd: 2 otherEnd: -10 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'.
	anErrorHandler
		should: [ Wormhole oneEnd: -10 otherEnd: -10 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'
]

{ #category : 'tests' }
WormholeTest >> testWhenWeCreateAWormholeWithEqualEndsThenItRaisesAnError [

	| anErrorHandler |
	anErrorHandler := MyErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Wormhole oneEnd: 2 otherEnd: 2 ]
		raiseErrorWithMessageText: 'Wormhole ends must be different tiles.'
]
