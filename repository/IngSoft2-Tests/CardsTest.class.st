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

{ #category : 'tests' }
CardsTest >> test01WhenUsingAnAccelerationThenItReturnsThrowPlusOne [

| anAccelerationCard aThrow |
anAccelerationCard:= Acceleration create.
aThrow := (LoadedDie rolling: 2) throw.

self assert: (anAccelerationCard applyBounsUsing: aThrow) equals: 3.

]

{ #category : 'tests' }
CardsTest >> test02WhenUsingAnSpeedThenItReturnsThrowPlusOne [

| aSpeedCard aThrow |
aSpeedCard := Speed createWithAnId: 1.
aThrow := (LoadedDie rolling: 2) throw.

self assert: (aSpeedCard applyBounsUsing: aThrow) equals: 3.

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
