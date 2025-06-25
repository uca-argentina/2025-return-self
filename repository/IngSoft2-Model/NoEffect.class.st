Class {
	#name : 'NoEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
NoEffect class >> effectProbability [

^0.30
]

{ #category : 'positioning' }
NoEffect >> applyEffectOn: aPlayer and: aGame [

]

{ #category : 'testing' }
NoEffect >> isNoEffect [ 

	^ true
]
