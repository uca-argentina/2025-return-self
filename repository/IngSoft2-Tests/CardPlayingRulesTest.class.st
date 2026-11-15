Class {
	#name : 'CardPlayingRulesTest',
	#superclass : 'GameWithCardsTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardPlayingRulesTest >> test01WhenTheGameHasFinishedThenTryingToPlayACardRaisesError [

	| aGame |
	aGame := self gameDealing: { Repeat } rolling: { 20 }.
	aGame playFullGame.
	self
		should: [ aGame player: aPlayer plays: (Repeat createWith: aPlayer) ]
		raiseErrorWithMessageText:
		'Cards cannot be played once the game has finished.'
]

{ #category : 'tests' }
CardPlayingRulesTest >> test02WhenTryingToPlayACardWithoutChoosingItsTargetThenItRaisesError [

	| aGame |
	aGame := self gameDealing: { Speed } rolling: { 3 }.
	self
		should: [ aGame player: aPlayer plays: Speed create ]
		raiseErrorWithMessageText: 'This card needs a target to be played.'
]

{ #category : 'tests' }
CardPlayingRulesTest >> test03WhenTryingToPlayACardOnAShipThatIsNotPlayingThenItRaisesError [

	| aGame aStranger |
	aStranger := ShipPlayerAssociation createWith: 9 and: 'Pedro'.
	aGame := self gameDealing: { Speed } rolling: { 3 }.
	self
		should: [ aGame player: aPlayer plays: (Speed createWith: aStranger) ]
		raiseErrorWithMessageText: 'Player not in list'
]
