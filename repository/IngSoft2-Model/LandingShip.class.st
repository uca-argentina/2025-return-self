Class {
	#name : 'LandingShip',
	#superclass : 'EffectTarget',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
LandingShip >> opposite [

	^ EveryOtherShip create
]

{ #category : 'accessing' }
LandingShip >> shipsAffectedWhen: aShip landsAmong: everyShip [

	^ everyShip select: [ :each | each equalsID: aShip ]
]
