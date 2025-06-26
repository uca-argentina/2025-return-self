Class {
	#name : 'CardManagerTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aPlayer',
		'aCardManager'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
CardManagerTest >> setUp [

	| aGroupOfPlayers |
	super setUp.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	aGroupOfPlayers := {
		                   aPlayer.
		                   (ShipPlayerAssociation createWith: 2 and: 'Tomi') }.
	aCardManager := CardManager
		                createWith: aGroupOfPlayers
		                and: OrderedCollection new
]

{ #category : 'tests' }
CardManagerTest >> test01ShipCanThrowACard [

	| speed aShipCards |
	speed := Speed create.
	aCardManager add: speed to: aPlayer.
	aShipCards := aCardManager findShipReference: aPlayer.
	self assert: aShipCards deck equals: speed asOrderedCollection
]
