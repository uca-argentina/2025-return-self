Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> testThrowDice [
	|dice|
	dice:= Dice faces: 6.
	self assert: (dice throw between: 1 and: 6)
]
