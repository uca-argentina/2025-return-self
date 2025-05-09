Class {
	#name : 'DummyTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DummyTest >> testDummy [

	self assert: Dummy new isDummy
]

{ #category : 'tests' }
DummyTest >> testThrowDice [
	|dice|
	dice:= Dice faces: 6.
	self assert: (dice throw between: 1 and: 6)
]
