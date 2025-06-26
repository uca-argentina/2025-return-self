"
A mock object to test the Effect application of the CardGiver
"
Class {
	#name : 'LoadedCardGiver',
	#superclass : 'Effect',
	#instVars : [
		'cardOrderedLooping',
		'actualCardIndex'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'creation' }
LoadedCardGiver class >> createWith: aListOfCards [

	^ self new initializeEffectWith: aListOfCards asOrderedCollection
]

{ #category : 'creation' }
LoadedCardGiver class >> effectProbability [

0.1
]

{ #category : 'positioning' }
LoadedCardGiver >> applyEffectOn: aPlayer and: aGame [

	| cardManager |
	cardManager := aGame requestCardManager: self.
	cardManager
		add: (cardOrderedLooping at: actualCardIndex) create
		to: aPlayer.

	self nextCard
]

{ #category : 'initialization' }
LoadedCardGiver >> initializeEffectWith: aListOfCards [

	cardOrderedLooping := aListOfCards.
	actualCardIndex := 1
]

{ #category : 'testing' }
LoadedCardGiver >> isCardGiver [

	^ true
]

{ #category : 'interaction loop' }
LoadedCardGiver >> nextCard [

	actualCardIndex := actualCardIndex \\ cardOrderedLooping size + 1
]
