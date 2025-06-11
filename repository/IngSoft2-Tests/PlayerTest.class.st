Class {
	#name : 'PlayerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PlayerTest >> testWhenAPlayerIsAskedItsNameThenReturnsItsName [

	| aPlayer |
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.

	self assert: aPlayer name equals: 'Juan'
]
