Class {
	#name : 'NoShip',
	#superclass : 'EffectTarget',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
NoShip >> opposite [

	^ EveryShip create
]

{ #category : 'accessing' }
NoShip >> shipsAffectedWhen: aShip landsAmong: everyShip [

	^ #(  )
]
