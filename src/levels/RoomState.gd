class_name RoomState extends Node

signal state_changed(old_state: State, new_state: State)

enum State {UNATTENDED,
            ATTENDING,
            ATTENDED
            }


const LEGAL = {
    State.UNATTENDED : [State.ATTENDING],
    State.ATTENDING : [State.ATTENDED],
    State.ATTENDED : [State.ATTENDING]
}

var state: State = State.UNATTENDED

func _set_state(new_state: State):
    if new_state == state:
        return
    if new_state not in LEGAL[state]:
        push_error("illegal state transition")
        return
    var old_state: State = state
    state = new_state
    state_changed.emit(old_state, state)


func enter() -> void:
    _set_state(State.ATTENDING)

func exit() -> void:
    _set_state(State.ATTENDED)
