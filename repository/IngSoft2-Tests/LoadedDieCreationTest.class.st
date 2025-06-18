Class {
	#name : 'LoadedDieCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LoadedDieCreationTest >> test01TryingToRollLowerThanOneRaisesAnError [

	self
		should: [ LoadedDie rolling: 0 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'.
	self
		should: [ LoadedDie rolling: -2 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'
]
