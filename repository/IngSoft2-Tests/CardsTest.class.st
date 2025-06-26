Class {
	#name : 'CardsTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aPlayer',
		'aGroupOfPlayers',
		'aTileListCreator'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
CardsTest >> setUp [

	super setUp.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	aGroupOfPlayers := {
		                   (ShipPlayerAssociation createWith: 1 and: 'Juan').
		                   (ShipPlayerAssociation createWith: 2 and: 'Tomi') }.
	aTileListCreator := TileListCreationForTesting createTileListWith: 20
]

{ #category : 'tests' }
CardsTest >> test01WhenUsingAnAccelerationThenItReturnsThrowPlusOne [

| anAccelerationCard aThrow |
anAccelerationCard:= Acceleration create.
aThrow := (LoadedDie rolling: 2) throw.

self assert: (anAccelerationCard applyBonusUsing: aThrow) equals: 3.

]

{ #category : 'tests' }
CardsTest >> test02WhenUsingAnSpeedThenItReturnsThrowPlusOne [

| aSpeedCard aThrow |
aSpeedCard := Speed createWithAnId: 1.
aThrow := (LoadedDie rolling: 2) throw.

self assert: (aSpeedCard applyBonusUsing: aThrow) equals: 3.

]

{ #category : 'tests' }
CardsTest >> test03WhenUsingACancellationCardThenItIsRemovedFromACardCollection [

| aCancellationCard aPlayingCard aPermanentCardCollection|
aCancellationCard:= Cancellation new.
aPlayingCard := Acceleration create.
aPermanentCardCollection := OrderedCollection with: aPlayingCard.
aCancellationCard cancelPlayingCard: aPlayingCard using: aPermanentCardCollection .
self assert: aPermanentCardCollection equals: OrderedCollection new. 


]

{ #category : 'tests' }
CardsTest >> test04WhenUsingARepeatCardOnAnotherPlayer [

	| aRepeatCard lastEffect aGame aTestBoard aLoadedDie |
	aRepeatCard := Repeat new.
	lastEffect := BlackHole create.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aLoadedDie := LoadedDie rolling: 8.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aLoadedDie
		         withLaps: 1.
	aGame nextPlayerThrowsDice.

	aRepeatCard
		replicateEffect: lastEffect 
		targeting: aPlayer
		using: aGame.
	self assert: (aGame positionFeatureOf: aPlayer) position
		equals: 5
]
