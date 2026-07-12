"
An effect that serves as a Null Object Pattern, to previous tests where Wormhole didnt apply. It may have a better use in the future.
"
Class {
	#name : 'NoEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'modifying' }
NoEffect >> applyEffectOn: aShip [

	^ aShip
]
