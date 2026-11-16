Class {
	#name : 'NoEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
NoEffect class >> effectProbability [

	^ 0.38
]

{ #category : 'testing' }
NoEffect >> allowsBattleOnItsTile [

	^ true
]

{ #category : 'positioning' }
NoEffect >> applyEffectOn: aPlayer and: aGame [

]

{ #category : 'testing' }
NoEffect >> isNoEffect [

	^ true
]

{ #category : 'accessing' }
NoEffect >> target [

	^ NoShip create
]
