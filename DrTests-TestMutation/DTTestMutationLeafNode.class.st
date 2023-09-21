Class {
	#name : 'DTTestMutationLeafNode',
	#superclass : 'DTTreeLeafNode',
	#category : 'DrTests-TestMutation-Model',
	#package : 'DrTests-TestMutation',
	#tag : 'Model'
}

{ #category : 'accessing' }
DTTestMutationLeafNode >> drTestsName [

	| originalString |
	originalString := self content asString.
	^ originalString copyWithoutAll: '#'
]
