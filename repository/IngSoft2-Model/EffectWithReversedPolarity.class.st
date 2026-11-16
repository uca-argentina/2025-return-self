Class {
	#name : 'EffectWithReversedPolarity',
	#superclass : 'Effect',
	#instVars : [
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
EffectWithReversedPolarity class >> effectProbability [

	^ 0
]

{ #category : 'creation' }
EffectWithReversedPolarity class >> of: anEffect [

	^ self new initializeOf: anEffect
]

{ #category : 'testing' }
EffectWithReversedPolarity >> allowsBattleOnItsTile [

	^ effect allowsBattleOnItsTile
]

{ #category : 'positioning' }
EffectWithReversedPolarity >> applyEffectOn: aPlayer and: aGame [

	effect applyEffectOn: aPlayer and: aGame
]

{ #category : 'positioning' }
EffectWithReversedPolarity >> applyEffectOnEvery: aGroupOfPlayers and: aGame [

	effect applyEffectOnEvery: aGroupOfPlayers and: aGame
]

{ #category : 'initialization' }
EffectWithReversedPolarity >> initializeOf: anEffect [

	effect := anEffect
]

{ #category : 'accessing' }
EffectWithReversedPolarity >> target [

	^ effect target opposite
]
