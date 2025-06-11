Class {
	#name : 'DiceCreationTest',
	#superclass : 'InstanceCreationTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceCreationTest >> testCreationOfDice [

	self
		should: [ Dice faces: -10 ]
		raiseErrorWithMessageText:
		'The number of faces must be greater than two.'
]
