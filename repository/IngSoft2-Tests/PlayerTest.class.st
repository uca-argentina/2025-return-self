Class {
	#name : 'PlayerTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PlayerTest >> test01WhenAPlayerIsAskedItsNameThenReturnsItsName [

	| aPlayer |
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.

	self assert: aPlayer name equals: 'Juan'
]

{ #category : 'tests' }
PlayerTest >> test02WhenTryingToMoveAPlayerFromOutsideTheGameItRasiesError [
	"Take into account that although we create or return a ShipPosition 
component, those objects are non-mutable, so it wont affect the game
ship position"

	| aPlayer |
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Pedro'.

	self
		should: [ aPlayer advanceTiles: 3 ]
		raiseErrorWithMessageText:
		'Message not understood: ShipPlayerAssociation >> #advanceTiles:'
]

{ #category : 'tests' }
PlayerTest >> test03WhenTryingToAddTurnsToSkipToAPlayerFromOutsideTheGameItRasiesError [
	"Take into account that although we create or return a ShipPosition 
component, those objects are non-mutable, so it wont affect the game
ship position"

	| aPlayer |
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Pedro'.

	self
		should: [ aPlayer addSkips: 2 ]
		raiseErrorWithMessageText:
		'Message not understood: ShipPlayerAssociation >> #addSkips:'
]

{ #category : 'tests' }
PlayerTest >> test04WhenTryingToReduceShieldsToAPlayerFromOutsideTheGameItRasiesError [
	"Take into account that although we create or return a ShipPosition 
component, those objects are non-mutable, so it wont affect the game
ship position"

	| aPlayer |
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Pedro'.

	self
		should: [ aPlayer loseShields: 1 ]
		raiseErrorWithMessageText:
		'Message not understood: ShipPlayerAssociation >> #loseShields:'
]
