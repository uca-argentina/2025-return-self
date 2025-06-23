Class {
	#name : 'Effect',
	#superclass : 'Object',
	#instVars : [
		'tile'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Effect class >> effectProbability [

self subclassResponsibility.
]

{ #category : 'positioning' }
Effect >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [

self subclassResponsibility.
]
