Class {
	#name : 'ReversePolarityCardTest',
	#superclass : 'GameWithCardsTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReversePolarityCardTest >> test01WhenTheTileOfAnEffectThatAffectsTheLandingShipIsReversedThenItAffectsEveryOtherShip [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 2, Lap: 0'.
							 'Name: Tomi, Position: 12, Lap: 0' }.
	aTileListCreator at: 12 put: BlackHole create.
	aGame := self gameDealing: { ReversePolarity } rolling: { 5. 11 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 12).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReversePolarityCardTest >> test02WhenTheTileOfAnEffectThatAffectsEveryOtherShipIsReversedThenItAffectsOnlyTheLandingShip [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 4, Lap: 0'.
							 'Name: Tomi, Position: 3, Lap: 0' }.
	aTileListCreator at: 7 put: (MoonWalk createEspeciallyWith: 3).
	aGame := self gameDealing: { ReversePolarity } rolling: { 6. 2 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 7).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReversePolarityCardTest >> test03WhenTheTileOfAnEffectThatAffectsEveryShipIsReversedThenItAffectsNoShip [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 3, Lap: 0'.
							 'Name: Tomi, Position: 5, Lap: 0' }.
	aTileListCreator at: 5 put: AtomikBomb create.
	aGame := self gameDealing: { ReversePolarity } rolling: { 2. 4 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 5).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData.
	self assert: (aGame shieldsFeatureOf: aPlayer) shields equals: 3.
	self assert: (aGame shieldsFeatureOf: anotherPlayer) shields equals: 3
]
