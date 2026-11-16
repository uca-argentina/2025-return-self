Class {
	#name : 'EffectTarget',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
EffectTarget class >> create [

	^ self new
]

{ #category : 'accessing' }
EffectTarget >> opposite [

	self subclassResponsibility
]

{ #category : 'accessing' }
EffectTarget >> shipsAffectedWhen: aShip landsAmong: everyShip [

	self subclassResponsibility
]
