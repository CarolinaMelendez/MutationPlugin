Class {
	#name : #DTTestMutationLeafNode,
	#superclass : #DTTreeLeafNode,
	#category : #'DrTests-TestMutation-Model'
}

{ #category : #accessing }
DTTestMutationLeafNode >> drTestsName [

	| originalString |
	originalString := self content asString.
	^ originalString copyWithoutAll: '#'
]
