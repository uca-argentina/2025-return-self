Class {
	#name : 'CardGiver',
	#superclass : 'Effect',
	#instVars : [
		'cardClasses'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardGiver class >> create [

	^ self new initializeEffect
]

{ #category : 'creation' }
CardGiver class >> effectProbability [

0.1
]

{ #category : 'positioning' }
CardGiver >> applyEffectOn: aPlayer and: aGame [

	| aRandomIndex aRandomCard cardManager |

	cardManager := aGame requestCardManager: self.
	aRandomIndex := (1 to: cardClasses size) atRandom.
	aRandomCard := (cardClasses at: aRandomIndex) new.
	cardManager add: aRandomCard to: aPlayer 
]

{ #category : 'initialization' }
CardGiver >> initializeEffect [

	cardClasses := {
		               Acceleration.
		               Cancellation.
		               Mercenary.
		               Redo.
		               Repeat.
		               Speed }
]

{ #category : 'testing' }
CardGiver >> isCardGiver [

	^ true
]
