Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#instVars : [
		'shipId'
	],
	#category : 'IngSoft2-Model-Objects',
	#package : 'IngSoft2-Model',
	#tag : 'Objects'
}

{ #category : 'testing' }
PermanentCard >> isPermanentCard [

^true
]

{ #category : 'accessing' }
PermanentCard >> shipId [

	^ shipId 
]
