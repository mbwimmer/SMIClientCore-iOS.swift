// SMIMultimediaCoreWrapper.swift
// Re-exports the SMIMultimediaCore framework along with its dependencies.
//
// SMIMultimediaCore (MIAW multimedia / voice) is a prebuilt binary xcframework
// that links against SMIMultimediaCommon and LiveKitWebRTC. binaryTargets can't
// declare dependencies, so this wrapper target carries them (same pattern as
// SMIClientCoreWrapper) and re-exports the module so consumers get one import.

// Re-export SMIMultimediaCore and its binary dependencies
@_exported import SMIMultimediaCore
@_exported import SMIMultimediaCommon

// Re-export LiveKitWebRTC, which SMIMultimediaCore links against for voice
@_exported import LiveKitWebRTC
