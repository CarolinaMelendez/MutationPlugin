Class {
	#name : 'BaselineOfDrTestsMutation',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfDrTestsMutation',
	#package : 'BaselineOfDrTestsMutation'
}

{ #category : 'baselines' }
BaselineOfDrTestsMutation >> baseline: spec [
	<baseline>
	"subclasses should redefine me"
	
	"Here is a typical package and its tests "
	spec for: #'common' do: [
		spec 
			package: #'DrTests-TestMutation' .
	spec
	baseline: 'MuTalk'
	with: [ spec repository: 'github://CarolinaMelendez/mutalk/src:nonStrictMode' ]
]
	
]

{ #category : 'accessing' }
BaselineOfDrTestsMutation >> projectClass [
    ^ MetacelloCypressBaselineProject
]
