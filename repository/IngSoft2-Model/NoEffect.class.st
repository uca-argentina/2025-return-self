Class {
	#name : 'NoEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
NoEffect class >> effectProbability [

^0.40
]

{ #category : 'positioning' }
NoEffect >> applyEffectOn: aGroupOfPlayers triggeredByPlayerAt: anIndex [
	^aGroupOfPlayers 
]
