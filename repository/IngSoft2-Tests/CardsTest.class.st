Class {
	#name : 'CardsTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aGroupOfPlayers'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
CardsTest >> setUp [
	super setUp.
	aGroupOfPlayers := {
		                   (ShipPlayerAssociation createWith: 1 and: 'Juan').
		                   (ShipPlayerAssociation createWith: 2 and: 'Tomi') }.
	"Put here a common initialization logic for tests"
]

{ #category : 'tests' }
CardsTest >> test01Banana [

	| speed aCardManager |
	speed := Speed new.
	aCardManager := CardManager createWith: aGroupOfPlayers.
	aCardManager add: speed to: (aGroupOfPlayers at: 1).
	self assert: false
]
