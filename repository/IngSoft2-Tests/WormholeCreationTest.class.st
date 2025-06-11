Class {
	#name : 'WormholeCreationTest',
	#superclass : 'InstanceCreationTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormholeCreationTest >> testWhenWeCreateAWormholeWithAtLeastOneEndLessThanOneThenItRaisesAnError [

	self
		should: [ Wormhole oneEnd: -10 otherEnd: 2 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'.
	self
		should: [ Wormhole oneEnd: 2 otherEnd: -10 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'.
	self
		should: [ Wormhole oneEnd: -10 otherEnd: -10 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'
]

{ #category : 'tests' }
WormholeCreationTest >> testWhenWeCreateAWormholeWithEqualEndsThenItRaisesAnError [

	self
		should: [ Wormhole oneEnd: 2 otherEnd: 2 ]
		raiseErrorWithMessageText: 'Wormhole ends must be different tiles.'
]
