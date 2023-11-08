from main import send_audio_key


# preferring the X86keys as it shows the notification - even though there is 500ms induced delay
send_audio_key(system, "MicMute")
# if I can invoke the popup showing mcirophone capture volume - I would use amixer to toggle mute via:
# amixer_mic_mute_toggle(system)
