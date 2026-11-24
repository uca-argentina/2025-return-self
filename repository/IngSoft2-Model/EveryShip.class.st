Class {
	#name : 'EveryShip',
	#superclass : 'EffectTarget',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
EveryShip >> opposite [

	^ NoShip create
]

{ #category : 'accessing' }
EveryShip >> shipsAffectedWhen: aShip landsAmong: everyShip [

	^ everyShip
]
