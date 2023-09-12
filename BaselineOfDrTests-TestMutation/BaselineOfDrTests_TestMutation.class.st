Class {
	#name : #'BaselineOfDrTests_TestMutation',
	#superclass : #BaselineOf,
	#category : #'BaselineOfDrTests-TestMutation'
}

{ #category : #baselines }
BaselineOfDrTests_TestMutation >> baseline: spec [
	<baseline>
	"subclasses should redefine me"
	
	"Here is a typical package and its tests "
	spec for: #'common' do: [
		spec 
			package: #'DrTests-TestMutation' .
	spec
	baseline: 'MuTalk'
	with: [ spec repository: 'github://pharo-contributions/mutalk/src' ]
]
	
]

{ #category : #accessing }
BaselineOfDrTests_TestMutation >> projectClass [
    ^ MetacelloCypressBaselineProject
]
