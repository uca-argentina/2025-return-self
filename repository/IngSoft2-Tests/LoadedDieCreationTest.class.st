Class {
	#name : 'LoadedDieCreationTest',
	#superclass : 'InstanceCreationTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LoadedDieCreationTest >> testTryingToRollLowerThanOneRaisesAnError [

	self
		should: [ LoadedDie rolling: 0 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'.
	self
		should: [ LoadedDie rolling: -2 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'
]
