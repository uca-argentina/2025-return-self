Class {
	#name : 'CardGiver',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardGiver class >> effectProbability [

	^ 0.10
]

{ #category : 'positioning' }
CardGiver >> applyEffectOn: aPlayer and: aGame [

	aGame dealCardTo: aPlayer
]
