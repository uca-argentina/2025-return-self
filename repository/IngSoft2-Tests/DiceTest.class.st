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

{ #category : 'tests' }
DiceTest >> testThrowMultipleDie [

	| firstDice secondDice aSetOfDie |
	
	firstDice := Dice faces: 6.
	secondDice := Dice faces: 9.
	aSetOfDie := DieSet having: {firstDice. secondDice}.
	self assert: ((aSetOfDie throw) between: 2 and: 15).

	
	

]

{ #category : 'tests' }
DiceTest >> testThrowMultipleLoadedDie [

	| firstLoadedDice secondLoadedDice aSetOfDie |
	
	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {firstLoadedDice. secondLoadedDice}.
	self assert: (aSetOfDie throw) equals: 8.

	
	

]
