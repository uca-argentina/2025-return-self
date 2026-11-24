Class {
	#name : 'NoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'setup' }
NoCard >> setupWith: aTarget [

	Error signal: 'There is no card played to do it again.'
]
