Class {
	#name : 'EmptyPlayer',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
EmptyPlayer >> move: doesntMatter [
^'Game is already over.'
]
