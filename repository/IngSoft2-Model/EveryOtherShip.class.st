Class {
	#name : 'EveryOtherShip',
	#superclass : 'EffectTarget',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
EveryOtherShip >> opposite [

	^ LandingShip create
]

{ #category : 'accessing' }
EveryOtherShip >> shipsAffectedWhen: aShip landsAmong: everyShip [

	^ everyShip reject: [ :each | each equalsID: aShip ]
]
